//
//  LoginViewController.swift
//  Feet
//
//  Created by 王振宇 on 6/21/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  

  @IBOutlet weak var phoneTextField: UITextField!
  @IBOutlet weak var codeTextField: UITextField!
  @IBOutlet weak var filedBackView: UIView!
  @IBOutlet weak var codeButon: UIButton!
  @IBOutlet weak var loginButton: UIButton!
  
  @IBOutlet weak var cancelBtn: UIButton!
  
  @IBOutlet weak var userInfoLabel: UILabel!
  
  // 计时器
  var timer: NSTimer!
  var leftTime = 60
  
  
  // MARK: - LifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    setViews()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    
    if let _ = timer {
      timer.invalidate()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  
  // MARK: - Acction
  @IBAction func dismissVC(sender: UIButton) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func timerAciton(sender: UIButton) {
    // 开启定时器
    view.endEditing(true)
    codeButon.enabled = false

    leftTime = 60
    timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(check), userInfo: nil, repeats: true)
    self.timer.fireDate = NSDate.distantPast()
    debugPrint("phone: \(phoneTextField.text!.deleteBlankSpace())")
    LoginNetTool.gainCode(["phone": phoneTextField.text!.deleteBlankSpace()]) { (promiseString) in
      do {
        let result = try promiseString.resolve()
        print(result)
      } catch where error is MyError{
        print("\(error)")
      } catch{
        debugPrint("网络错误")
      }
    }
  }
  
  func check() {
    leftTime = leftTime - 1
    codeButon.setTitle("\(leftTime)", forState: .Normal)
    
    if leftTime == 0 {
      leftTime = 60
      // 关闭定时器
      timer.fireDate = NSDate.distantFuture()
      codeButon.enabled = true
      codeButon.setTitle("重新获取", forState: .Normal)
    }
  }
  
  
  // MARK: - SetViews
  func setViews() {
    view.insertSubview(BackView(), atIndex: 0)

    filedBackView.layer.cornerRadius = 6
    filedBackView.layer.borderColor = UIColor.whiteColor().CGColor
    filedBackView.layer.borderWidth = 2
    filedBackView.layer.masksToBounds = true
    filedBackView.backgroundColor = UIColor(hexString: "#FFFFFF", alpha: 0.1)
    filedBackView.alpha = 0.1
    
    phoneTextField.keyboardType = UIKeyboardType.NumberPad
    phoneTextField.delegate = self
    phoneTextField.addTarget(self, action: #selector(checkInfo), forControlEvents: .EditingChanged)

    
    codeTextField.keyboardType = UIKeyboardType.NumberPad
    codeTextField.addTarget(self, action: #selector(checkInfo), forControlEvents: .EditingChanged)
    codeTextField.delegate = self
    
    loginButton.layer.cornerRadius = 6
    loginButton.layer.masksToBounds = true
    changeLoginBtnColor(false)
    loginButton.addTarget(self, action: #selector(loginAction), forControlEvents: .TouchUpInside)
    
    let text = NSMutableAttributedString(string: "点击登录，即表示您已同意《Feet用户协议》")
    text.addAttribute(NSForegroundColorAttributeName, value: UIColor(hexString: "#11d211"), range: NSMakeRange(13, 8))
    userInfoLabel.attributedText = text
    userInfoLabel.userInteractionEnabled = true
    let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(pushToUserInfo))
    userInfoLabel.addGestureRecognizer(tapGestrue)
  }

  
  // MARK: - Method
  func changeLoginBtnColor(bool: Bool) {
    if bool {
      loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
      loginButton.backgroundColor = UIColor(hexString: "#11d211")
    } else {
      let normalColor = UIColor(hexString: "#646464")
      let normalBackColor = UIColor.whiteColor()
      loginButton.backgroundColor = normalBackColor
      loginButton.setTitleColor(normalColor, forState: .Normal)
    }
  }
  
  func checkInfo() {
    if phoneTextField.length != 0 && codeTextField.length != 0 {
      changeLoginBtnColor(true)
    } else {
      changeLoginBtnColor(false)
    }
  }
  
  func pushToUserInfo() {
    debugPrint("跳转到用户协议")
  }
  
  func loginAction() {
    let param = [
      "phone": phoneTextField.text!.deleteBlankSpace(),
      "smsCode": codeTextField.text!
    ]
    
    LoginNetTool.logIn(param) { promiseModel in
      do {
        let _ = try promiseModel.then({model in
          self.dismissViewControllerAnimated(true, completion: nil)
          UserDefaultsTool.userToken = model.token
        }).resolve()
      } catch where error is MyError{
        debugPrint("\(error)")
      } catch{
        debugPrint("网络错误")
      }
    }
  }
}


// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
    if textField ==  phoneTextField {
      return textField.insertBlankSpace(textField, range: range, string: string)
    } else	 {
      return textField.textMaxLength(textField, range: range, string: string, maxLength: 6)
    }
    
  }
}

//
//  LoginViewController.swift
//  Feet
//
//  Created by 王振宇 on 6/21/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
  
  
  @IBOutlet weak var titleLabel: UILabel!

  @IBOutlet weak var phoneTextField: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var filedBackView: UIView!
  @IBOutlet weak var codeButon: UIButton!
  @IBOutlet weak var loginButton: UIButton!
  
  @IBOutlet weak var cancelBtn: UIButton!
  
  @IBOutlet weak var userInfoLabel: UILabel!
  
  // 注册
  @IBOutlet weak var password2: UITextField!
  @IBOutlet weak var checkCode: UITextField!
  @IBOutlet weak var codeImageView: UIImageView!
  
  
  // 约束
  @IBOutlet weak var filedBackViewHeight: NSLayoutConstraint!
  
  
  // 计时器
  var timer: Timer!
  var leftTime = 60
  
  
  // MARK: - LifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    setViews()
    
    // 
    filedBackViewHeight.constant = 93
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    if let _ = timer {
      timer.invalidate()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override var preferredStatusBarStyle : UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
  }
  
  
  // MARK: - Acction
  @IBAction func changeAction(_ sender: UIButton) {
    if sender.titleLabel?.text == "注册" {
      sender.setTitle	("登录", for: UIControlState())
      titleLabel.text = "注册"
      loginButton.setTitle("注册", for: UIControlState())
//      LoginService.downLoadImage(codeImaegURL, compeltion: { (data, str) in
//        self.codeImageView.image = UIImage(data: data)
//      })
      ApiClient.downLoadImage(codeImaegURL, compeletion: { (data, str) in
        if let data = data {
          self.codeImageView.image = UIImage(data: data)
        }
      })
      
      view.setNeedsUpdateConstraints()
      UIView.animate(withDuration: 0.3, animations: {
        self.filedBackViewHeight.constant = 186
        self.view.layoutIfNeeded()
      })
    } else {
      sender.setTitle("注册", for: UIControlState())
      titleLabel.text = "登录"
      loginButton.setTitle("登录", for: UIControlState())
  
      view.setNeedsUpdateConstraints()
      UIView.animate(withDuration: 0.3, animations: {
        self.filedBackViewHeight.constant = 93
        self.view.layoutIfNeeded()
      })
    }
  }
  
  @IBAction func dismissVC(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func timerAciton(_ sender: UIButton) {
    // 开启定时器
    view.endEditing(true)
    codeButon.isEnabled = false

    leftTime = 60
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(check), userInfo: nil, repeats: true)
    self.timer.fireDate = Date.distantPast
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
    codeButon.setTitle("\(leftTime)", for: UIControlState())
    
    if leftTime == 0 {
      leftTime = 60
      // 关闭定时器
      timer.fireDate = Date.distantFuture
      codeButon.isEnabled = true
      codeButon.setTitle("重新获取", for: UIControlState())
    }
  }
  
  
  // MARK: - SetViews
  func setViews() {
    view.insertSubview(BackView(), at: 0)

    filedBackView.layer.cornerRadius = 6
    filedBackView.layer.borderColor = UIColor(hexString: "#FFFFFF", alpha: 0.1).cgColor
    filedBackView.layer.borderWidth = 2
    filedBackView.layer.masksToBounds = true
    filedBackView.backgroundColor = UIColor(hexString: "#FFFFFF", alpha: 0.1)
    
    phoneTextField.keyboardType = UIKeyboardType.numberPad
    phoneTextField.delegate = self
    phoneTextField.addTarget(self, action: #selector(checkInfo), for: .editingChanged)

    
    password.addTarget(self, action: #selector(checkInfo), for: .editingChanged)
    password.clearButtonMode = .whileEditing
    password.isSecureTextEntry = true
    password2.clearButtonMode = .whileEditing
    password2.isSecureTextEntry = true
    password.delegate = self
    
    loginButton.layer.cornerRadius = 6
    loginButton.layer.masksToBounds = true
    changeLoginBtnColor(false)
    loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    
    let text = NSMutableAttributedString(string: "点击登录，即表示您已同意《Feet用户协议》")
    text.addAttribute(NSForegroundColorAttributeName, value: UIColor(hexString: "#11d211"), range: NSMakeRange(13, 8))
    userInfoLabel.attributedText = text
    userInfoLabel.isUserInteractionEnabled = true
    let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(pushToUserInfo))
    userInfoLabel.addGestureRecognizer(tapGestrue)
  }

  
  // MARK: - Method
  func changeLoginBtnColor(_ bool: Bool) {
    if bool {
      loginButton.setTitleColor(UIColor.white, for: UIControlState())
      loginButton.backgroundColor = UIColor(hexString: "#11d211")
    } else {
      let normalColor = UIColor(hexString: "#646464")
      let normalBackColor = UIColor.white
      loginButton.backgroundColor = normalBackColor
      loginButton.setTitleColor(normalColor, for: UIControlState())
    }
  }
  
  func checkInfo() {
    phoneTextField.numberOnly()
    if phoneTextField.length != 0 && password.length != 0 {
      changeLoginBtnColor(true)
    } else {
      changeLoginBtnColor(false)
    }
  }
  
  func pushToUserInfo() {
    debugPrint("跳转到用户协议")
  }
  
  func loginAction() {
    let loginParam = [
      "nickname": phoneTextField.text!.deleteBlankSpace(),
      "pwd": password.text!
    ]
    
    let registParam = [
      "nickname": phoneTextField.text!.deleteBlankSpace(),
      "pwd": password.text!,
      "pwdAgain": password2.text ?? "",
      "capcode": checkCode.text ?? ""
    ]
    
    if loginButton.titleLabel?.text == "登录" {
      LoginNetTool.newLogin(loginParam) { promiseModel in
        do {
          let _ = try promiseModel.then({model in
            UserDefaultsTool.saveInfo(model)
            if model.image != "" {
              ApiClient.downLoadImage(model.image, compeletion: { (data, cookieString) in
                UserDefaultsTool.headerData = data!
                self.dismiss(animated: true, completion: nil)
              })
            } else {
              self.dismiss(animated: true, completion: nil)
            }
          }).resolve()
        } catch where error is MyError{
          debugPrint("\(error)")
          HUD.showError("\(error)")
        } catch{
          debugPrint("网络错误")
        }
      }
    } else {
      LoginNetTool.regist(registParam) { promiseModel in
        do {
          let _ = try promiseModel.then({model in
            UserDefaultsTool.saveInfo(model)
            if model.image != "" {
              ApiClient.downLoadImage(model.image, compeletion: { (data, cookieString) in
                UserDefaultsTool.headerData = data!
                self.dismiss(animated: true, completion: nil)
              })
            } else {
              self.dismiss(animated: true, completion: nil)
            }
          }).resolve()
        } catch where error is MyError{
          debugPrint("\(error)")
          HUD.showError("\(error)")
        } catch{
          debugPrint("网络错误")
        }
      }
    }
  }
}


// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if textField == phoneTextField {
      return textField.textMaxLength(textField, range: range, string: string, maxLength: 11)
    }
    return true
  }
}

//
//  SetUserInfoViewController.swift
//  Feet
//
//  Created by 王振宇 on 7/31/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

enum InfoViews {
  
  case sign
  case name
  case sex
  case birthday
  case email
  
  init(type: Int){
    switch type {
    case 102:
      self = .sign
    case 103:
      self = .name
    case 104:
      self = .sex
    case 105:
      self = .birthday
    case 106:
      self = .email
    default:
      self = .email
    }
  }
}

class SetUserInfoViewController: UIViewController {
  
  var infoType = InfoViews.sign
  weak var subView: UIView!
  
  // MARK: - LifeCycle
  convenience init(type: InfoViews) {
    self.init()
    infoType = type
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    view.addSubview(BackView())
    subView = returnView()
    //
    let btn = BorderButton(frame: CGRect(x: 0, y: 0, width: 50, height: 24))
    btn.addTarget(self, action: #selector(saveAciton), forControlEvents: .TouchUpInside)
    let rightBarItem = UIBarButtonItem(customView: btn)
    navigationItem.rightBarButtonItem = rightBarItem
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // Method
  func returnView() -> UIView {
    var v: UIView!
    switch infoType {
    case .sign:
      v = createView(SignView.self)
      break
    case .name:
      v = createView(NameView.self)
      break
    case .sex:
      v = createView(SexView.self)
    case .birthday:
      v = createView(BirthdayView.self)
      break
    case .email:
      v = createView(EmailView.self)
    }
    
    view.addSubview(v)
    v.snp_makeConstraints { (make) in
      make.top.left.bottom.right.equalTo(view)
    }
    return v
  }
  
  func createView<T: UIView>(type: T.Type) -> T{
    let t = T()
    return t
  }
}

// MARK: - 
extension SetUserInfoViewController {
  func saveAciton() {
    switch infoType {
    case .sign:
      let sign = (subView as! SignView).sign
      if sign.length() > 0 {
        save(["info": sign])
      } else {
        debugPrint("侬能留下点东西吗")
      }
      break
    case .name:
      let name = (subView as! NameView).name
      if name.length() > 0 {
        save(["nickname": name])
      } else {
        debugPrint("侬的名字不能为空哦")
      }
      break
    case .sex:
      // TODO ....
      let sex = (subView as! SexView).sex
      save(["gender": "\(sex)"])
    case .birthday:
      let birthday = (subView as! BirthdayView).birthday
      if birthday.length() > 0 {
        save(["birthday": birthday])
      } else {
        debugPrint("侬的生日跑哪去了")
      }
      break
    case .email:
      let email = (subView as! EmailView).email
      if email.length() > 0 {
        save(["email": email])
      } else {
        debugPrint("侬的邮箱不见了。。。")
      }
    }
  }

  func save(param: [String: String]) {
     UserNetworkTool.userInfo(param) { (promiseModel) in
      do {
        let _  = try promiseModel.then({model in
          debugPrint(model)
          self.navigationController?.popViewControllerAnimated(true)
        }).resolve()
      } catch where error is MyError{
        debugPrint("\(error)")
      } catch{
        debugPrint("网络错误")
      }
    }
  }
}


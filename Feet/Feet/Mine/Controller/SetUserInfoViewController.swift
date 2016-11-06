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
    case .name:
      v = createView(NameView.self)
    case .sex:
      v = createView(SexView.self)
    case .birthday:
      v = createView(BirthdayView.self)
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


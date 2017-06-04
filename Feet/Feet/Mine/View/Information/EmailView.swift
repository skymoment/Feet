//
//  EmailView.swift
//  Feet
//
//  Created by 王振宇 on 10/7/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class EmailView: UIView {

  weak var boderField: BorderTextField!
  var email: String {
    get {
      return boderField.text
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setViews() {
    let h = TransparentView()
    self.addSubview(h)
    h.snp.makeConstraints { (make) in
      make.top.equalTo(64 + 15)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(180)
    }
    
    let emailImage = UIImageView(image: UIImage(named:"email"))
    h.addSubview(emailImage)
    emailImage.snp.makeConstraints({ (make) in
      make.top.equalTo(15)
      make.centerX.equalTo(h)
      make.width.height.equalTo(28)
    })
    
    boderField = {
      let b = BorderTextField()
      b.placeHolder = "侬给邮箱是啥？"
      h.addSubview(b)
      b.snp.makeConstraints { (make) in
        make.top.equalTo(emailImage.snp.bottom).offset(50)
        make.left.equalTo(h.snp.left).offset(20)
        make.right.equalTo(h.snp.right).offset(-20)
        make.height.equalTo(40)
      }
      return b
    }()
  }
}

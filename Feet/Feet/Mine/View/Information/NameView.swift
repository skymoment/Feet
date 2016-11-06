//
//  NameView.swift
//  Feet
//
//  Created by 王振宇 on 10/7/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class NameView: UIView {

  weak var boderField: BorderTextField!
  
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
    h.snp_makeConstraints { (make) in
      make.top.equalTo(64 + 15)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(180)
    }
    
    let nameImage = UIImageView(image: UIImage(named:"name"))
    h.addSubview(nameImage)
    nameImage.snp_makeConstraints(closure: { (make) in
      make.top.equalTo(15)
      make.centerX.equalTo(h)
      make.width.height.equalTo(28)
    })
    
    boderField = {
      let b = BorderTextField()
      b.placeHolder = "侬叫啥"
      h.addSubview(b)
      b.snp_makeConstraints { (make) in
        make.top.equalTo(nameImage.snp_bottom).offset(50)
        make.left.equalTo(h.snp_left).offset(20)
        make.right.equalTo(h.snp_right).offset(-20)
        make.height.equalTo(40)
      }
      return b
    }()
    
    let b = UIButton(type: .System)
    b.setTitle("保 存", forState: .Normal)
    b.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    
    b.layer.borderWidth = 1
    b.layer.borderColor = UIColor.whiteColor().CGColor
    b.layer.cornerRadius = 3
    b.frame = CGRect(x: 80, y: 150, width: 50, height: 26)
    
    h.addSubview(b)
  }
  
  
  func saveAction() {
  
  }
}

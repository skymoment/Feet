//
//  SexView.swift
//  Feet
//
//  Created by 王振宇 on 10/7/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class SexView: UIView {

  var sex:Int = 0
  
  weak var manBtn: BorderButton!
  weak var womanBtn: BorderButton!
  
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
    
    
    let label = UILabel()
    h.addSubview(label)
    label.textColor = UIColor.whiteColor()
    label.text = "or"
    label.font = UIFont.systemFontOfSize(20)
    label.snp_makeConstraints(closure: { (make) in
      make.centerX.equalTo(h)
      make.top.equalTo(15)
    })
    
    
    let manImage = UIImageView(image: UIImage(named:"sex_m_d"))
    h.addSubview(manImage)
    manImage.snp_makeConstraints(closure: { (make) in
      make.centerY.equalTo(label)
      make.right.equalTo(label.snp_left).offset(-8)
      make.width.height.equalTo(24)
    })
    
    let womanImage = UIImageView(image: UIImage(named:"sex_m_d"))
    h.addSubview(womanImage)
    womanImage.snp_makeConstraints(closure: { (make) in
      make.centerY.equalTo(label)
      make.left.equalTo(label.snp_right).offset(8)
      make.width.height.equalTo(24)
    })
    
    manBtn = {
      let manBtn = BorderButton()
      manBtn.tag = 0
      manBtn.setTitle("男", forState: .Normal)
      h.addSubview(manBtn)
      manBtn.addTarget(self, action: #selector(sexButton), forControlEvents: .TouchUpInside)
      manBtn.snp_makeConstraints { (make) in
        make.top.equalTo(label.snp_bottom).offset(30)
        make.centerX.equalTo(h)
        make.width.equalTo(100)
        make.height.equalTo(35)
      }
      return manBtn
    }()
    
    womanBtn = {
      let womanBtn = BorderButton()
      womanBtn.tag = 1
      womanBtn.setTitle("女", forState: .Normal)
      h.addSubview(womanBtn)
      womanBtn.addTarget(self, action: #selector(sexButton), forControlEvents: .TouchUpInside)
      womanBtn.snp_makeConstraints { (make) in
        make.top.equalTo(manBtn.snp_bottom).offset(15)
        make.centerX.equalTo(h)
        make.width.equalTo(100)
        make.height.equalTo(35)
      }
      return womanBtn
    }()
  }
  
  func sexButton(button: UIButton) {
    sex = button.tag
    if sex == 0 {
      manBtn.backgroundColor = UIColor.lightGrayColor()
      womanBtn.backgroundColor = UIColor.clearColor()
    } else {
      manBtn.backgroundColor = UIColor.clearColor()
      womanBtn.backgroundColor = UIColor.lightGrayColor()
    }
  }
}

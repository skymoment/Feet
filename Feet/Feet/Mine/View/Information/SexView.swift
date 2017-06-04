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
    h.snp.makeConstraints { (make) in
      make.top.equalTo(64 + 15)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(180)
    }
    
    
    let label = UILabel()
    h.addSubview(label)
    label.textColor = UIColor.white
    label.text = "or"
    label.font = UIFont.systemFont(ofSize: 20)
    label.snp.makeConstraints({ (make) in
      make.centerX.equalTo(h)
      make.top.equalTo(15)
    })
    
    
    let manImage = UIImageView(image: UIImage(named:"sex_m_d"))
    h.addSubview(manImage)
    manImage.snp.makeConstraints({ (make) in
      make.centerY.equalTo(label)
      make.right.equalTo(label.snp.left).offset(-8)
      make.width.height.equalTo(24)
    })
    
    let womanImage = UIImageView(image: UIImage(named:"sex_m_d"))
    h.addSubview(womanImage)
    womanImage.snp.makeConstraints({ (make) in
      make.centerY.equalTo(label)
      make.left.equalTo(label.snp.right).offset(8)
      make.width.height.equalTo(24)
    })
    
    manBtn = {
      let manBtn = BorderButton()
      manBtn.tag = 0
      manBtn.setTitle("男", for: UIControlState())
      h.addSubview(manBtn)
      manBtn.addTarget(self, action: #selector(sexButton), for: .touchUpInside)
      manBtn.snp.makeConstraints { (make) in
        make.top.equalTo(label.snp.bottom).offset(30)
        make.centerX.equalTo(h)
        make.width.equalTo(100)
        make.height.equalTo(35)
      }
      return manBtn
    }()
    
    womanBtn = {
      let womanBtn = BorderButton()
      womanBtn.tag = 1
      womanBtn.setTitle("女", for: UIControlState())
      h.addSubview(womanBtn)
      womanBtn.addTarget(self, action: #selector(sexButton), for: .touchUpInside)
      womanBtn.snp.makeConstraints { (make) in
        make.top.equalTo(manBtn.snp.bottom).offset(15)
        make.centerX.equalTo(h)
        make.width.equalTo(100)
        make.height.equalTo(35)
      }
      return womanBtn
    }()
  }
  
  func sexButton(_ button: UIButton) {
    sex = button.tag
    if sex == 0 {
      manBtn.backgroundColor = UIColor.lightGray
      womanBtn.backgroundColor = UIColor.clear
    } else {
      manBtn.backgroundColor = UIColor.clear
      womanBtn.backgroundColor = UIColor.lightGray
    }
  }
}

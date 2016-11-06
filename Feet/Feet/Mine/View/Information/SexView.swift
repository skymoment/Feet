//
//  SexView.swift
//  Feet
//
//  Created by 王振宇 on 10/7/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class SexView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
  
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
  }
}

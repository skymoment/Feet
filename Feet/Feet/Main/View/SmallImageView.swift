//
//  SmallImageView.swift
//  Feet
//
//  Created by 王振宇 on 7/9/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class SmallImageView: UIImageView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayer()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setLayer() {
    self.layer.borderWidth = 0
    self.layer.borderColor = UIColor.blackColor().CGColor
    self.layer.shadowColor = UIColor.blackColor().CGColor //shadowColor阴影颜色
    self.layer.shadowOffset = CGSize(width: 2,height: 2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    self.layer.shadowRadius = 2;
  }
}

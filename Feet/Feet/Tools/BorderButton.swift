//
//  BorderButton.swift
//  Feet
//
//  Created by zhenyu on 10/29/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class BorderButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setViews() {
    setTitle("保 存", forState: .Normal)
    setTitleColor(UIColor.whiteColor(), forState: .Normal)
    titleLabel?.font = UIFont.systemFontOfSize(15)
    tintColor = UIColor.whiteColor()
    layer.borderWidth = 1
    layer.borderColor = UIColor.whiteColor().CGColor
    layer.cornerRadius = 3
  }
}

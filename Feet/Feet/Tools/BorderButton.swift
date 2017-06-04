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
    setTitle("保 存", for: UIControlState())
    setTitleColor(UIColor.white, for: UIControlState())
    titleLabel?.font = UIFont.systemFont(ofSize: 15)
    tintColor = UIColor.white
    layer.borderWidth = 1
    layer.borderColor = UIColor.white.cgColor
    layer.cornerRadius = 3
  }
}

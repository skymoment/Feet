//
//  TransparentView.swift
//  Feet
//
//  Created by 王振宇 on 7/31/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class TransparentView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setProperty()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setProperty() {
    self.backgroundColor = UIColor(hexString: "#000000", alpha: 0.1)
    self.layer.cornerRadius = 6
    self.layer.masksToBounds = true
  }
}

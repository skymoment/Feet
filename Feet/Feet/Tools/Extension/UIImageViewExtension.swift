//
//  UIImageViewExtension.swift
//  Feet
//
//  Created by 王振宇 on 8/17/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

extension UIImageView {
  func cornerRadiusImageView(_ cornerRadius:CGFloat) {
    self.layer.cornerRadius = cornerRadius
    self.layer.masksToBounds = true
  }
}

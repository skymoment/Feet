//
//  HUD.swift
//  Feet
//
//  Created by zhenyu on 17/1/3.
//  Copyright © 2017年 王振宇. All rights reserved.
//

import Foundation
import SVProgressHUD

class HUD {
  static func show() {
    SVProgressHUD.show()
  }
  
  static func dismiss() {
    SVProgressHUD.dismiss()
  }
  
  static func show(title title: String) {
    SVProgressHUD.showWithStatus(title)
  }
  
  static func showError(status status: String) {
    SVProgressHUD.showErrorWithStatus(status)
  }
  
  static func showSuccess(status status: String) {
    SVProgressHUD.showSuccessWithStatus(status)
  }
}

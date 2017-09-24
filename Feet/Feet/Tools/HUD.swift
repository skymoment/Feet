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
    
    static func show(_ title: String) {
        SVProgressHUD.show(withStatus: title)
    }
    
    static func showError(_ status: String) {
        SVProgressHUD.showError(withStatus: status)
    }
    
    static func showSuccess(_ status: String) {
        SVProgressHUD.showSuccess(withStatus: status)
    }
    
    static func toast(_ title: String) {
        SVProgressHUD.setMaximumDismissTimeInterval(1.4)
        SVProgressHUD.setMinimumDismissTimeInterval(1.4)
        SVProgressHUD.setInfoImage(UIImage(named: "name"))
        SVProgressHUD.showInfo(withStatus: title)
    }
}

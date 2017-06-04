//
//  ControllerTool.swift
//  PaydayLoan
//
//  Created by 张霄男 on 8/25/16.
//  Copyright © 2016 QianShengQian, Inc. All rights reserved.
//

import UIKit

struct ControllerTool {
    static func chooseRootViewController() -> UIViewController {
        let userDefaults = UserDefaults.standard
        // 检查沙盒中的版本号，如果存储的版本号和本次版本号不同或者版本号不存在，显示新特性界面，并保存mainBundle里面的版本号，比如1789
        let lastVersion = userDefaults.string(forKey: String(kCFBundleVersionKey)) ?? ""
        let currentVersion = Bundle.main.infoDictionary![String(kCFBundleVersionKey)] as! String
        
        if lastVersion == currentVersion {
          return TabBarController()
        } else {
          userDefaults.set(currentVersion, forKey: String(kCFBundleVersionKey))
          userDefaults.synchronize()
          return FeatureViewController()
        }
    }
}

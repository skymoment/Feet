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
        let userDefaults = NSUserDefaults.standardUserDefaults()
        // 检查沙盒中的版本号，如果存储的版本号和本次版本号不同或者版本号不存在，显示新特性界面，并保存mainBundle里面的版本号，比如1789
        let lastVersion = userDefaults.stringForKey(String(kCFBundleVersionKey)) ?? ""
        let currentVersion = NSBundle.mainBundle().infoDictionary![String(kCFBundleVersionKey)] as! String
        
        if lastVersion == currentVersion {
          return FeatureViewController()
        } else {
          userDefaults.setObject(currentVersion, forKey: String(kCFBundleVersionKey))
          userDefaults.synchronize()
          return FeatureViewController()
        }
    }
}

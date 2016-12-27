//
//  Constants.swift
//  SwiftCocoa
//
//  Created by 王振宇 on 7/6/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation
/// 七牛空间
let QNHeader = "http://o8ahkpej6.bkt.clouddn.com/"


// iPhone 
let iPhone4 = UIScreen.mainScreen().bounds.height == 480
let iPhone5 = UIScreen.mainScreen().bounds.height == 568
let smallScreen = UIScreen.mainScreen().bounds.width == 320 ? true : false


// Colors
let MianFontColor = UIColor(hexString: "#282828")
let LineColor = UIColor(hexString: "#dcdcdc")
let GreenFontColor = UIColor(hexString: "#11d211")

// UIScreen 
let KScreenWidth = UIScreen.mainScreen().bounds.width
let KScreenHeigth = UIScreen.mainScreen().bounds.height

// APP 版本
let KAppVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]!

let mainTextColor = UIColor(hexString: "#646464")

/// 获取应用沙盒缓存目录
/// 用于存放应用程序专用的支持文件，保存应用程序再次启动过程中需要的信息
let  cacheFolderPath: String =  NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0]

/// 获取 Document 目录
/// Documents 目录：您应该将所有的应用程序数据文件写入到这个目录下。这个目录用于存储用户数据或其它应该定期备份的信息。
let documentPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]

var timeStampInt: Int {
    let date = NSDate().timeIntervalSince1970 * 1000
    let dateInt = Int(date)
    return dateInt
}

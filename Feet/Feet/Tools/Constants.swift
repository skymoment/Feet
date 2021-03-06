//
//  Constants.swift
//  SwiftCocoa
//
//  Created by 王振宇 on 7/6/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation

/// window
let kWindow = UIApplication.shared.delegate?.window!

/// 七牛空间
let QNHeader = "http://o8ahkpej6.bkt.clouddn.com/"

// iPhone 
let iPhone4 = UIScreen.main.bounds.height == 480
let iPhone5 = UIScreen.main.bounds.height == 568
let iPhonePlus = UIScreen.main.bounds.height == 736
let smallScreen = UIScreen.main.bounds.width == 320 ? true : false
let iPad = UIScreen.main.bounds.height > 736

// Colors
let MianFontColor = UIColor(hexString: "#282828")
let LineColor = UIColor(hexString: "#dcdcdc")
let GreenFontColor = UIColor(hexString: "#11d211")

let FangZheng = "FZXingKai-S04S"

// UIScreen
let KScreenWidth = UIScreen.main.bounds.width
let KScreenHeigth = UIScreen.main.bounds.height
let subString = "?imageView2/1/w/\(Int(KScreenWidth - 30)*3)/h/\(Int(KScreenWidth - 30)*3)/interlace/1"


// APP 版本
let KAppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"]!

let mainTextColor = UIColor(hexString: "#646464")

/// 获取应用沙盒缓存目录
/// 用于存放应用程序专用的支持文件，保存应用程序再次启动过程中需要的信息
let  cacheFolderPath: String =  NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]

/// 获取 Document 目录
/// Documents 目录：您应该将所有的应用程序数据文件写入到这个目录下。这个目录用于存储用户数据或其它应该定期备份的信息。
let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

var timeStampInt: Int {
    let date = Date().timeIntervalSince1970 * 1000
    let dateInt = Int(date)
    return dateInt
}

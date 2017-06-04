//
//  ZhuGeio.swift
//  Feet
//
//  Created by 王振宇 on 6/1/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation
import Zhugeio

class ZhuGeio: NSObject {
  
  static func zhugeStratWithAppKey(_ launchOptions : [AnyHashable: Any]?) {
    
     setSDKObserverSetting()
 Zhuge.sharedInstance().start(withAppKey: "57d5b00d099845e78eb8c1263654c38a",
                                           launchOptions: launchOptions)
     setUserIdentify()
  }
  
  
  /**
   配置SDK
   */
  static func setSDKObserverSetting() {
    let zhuge = Zhuge.sharedInstance()
    let zhugeConfig = zhuge.config()
    
    // 调试模式
    zhugeConfig.debug = true
    
    // 可视化事件布点手势监听开关（耗电）
//    zhuge.openGestureBindingUI()
    
    // 自定义渠道
    zhugeConfig.channel = "豆瓣"
    //[zhuge.config setChannel:@"My App Store"]; // 默认是@"App Store"
    
    // 打开SDK日志打印。此接口在诸葛io SDK 2.0以上版本不再提供
    //[zhuge.config setLogEnabled:NO]; // 默认关闭
  }
  
  
  /**
   设置用户基本信息
   */
  static func setUserIdentify() {
    
    let identifier = "13052319103"
    var userInfo = [String:String]()
    userInfo["name"] = "王振"
    userInfo["moblie"] = "13052319103"
    
    Zhuge.sharedInstance().identify(identifier, properties: userInfo)
  }
  
  
  /**
   记录用户事件
   
   - parameter track:     用户事件
   - parameter trackInfo: 事件描述
   */
  static func RecordUserTrack(_ track: String, trackInfo: [String: String]) {
    Zhuge.sharedInstance().track(track, properties: trackInfo)
  }
}

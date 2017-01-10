//
//  UserDefalutTool.swift
//  Feet
//
//  Created by 王振宇 on 7/10/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation

class UserDefaultsTool {
  /*************************************************/

  /// 用户名
  static var userName: String {
    set{
      UserDefaultsTool.save(newValue, key: "userName")
    }
    get{
      let userDefaults = NSUserDefaults.standardUserDefaults()
      return userDefaults.stringForKey("userName") ?? ""
    }
  }
  
  /// 用户头像
  static var headerData: NSData? {
    set{
      UserDefaultsTool.save(newValue!, key: "headerData")
    }
    get{
      let userDefaults = NSUserDefaults.standardUserDefaults()
      userDefaults.dataForKey("headerData")
      return userDefaults.dataForKey("headerData")
    }
  }
  
  /// 签名
  static var sign: String {
    set{
      UserDefaultsTool.save(newValue, key: "info")
    }
    get{
      let userDefaults = NSUserDefaults.standardUserDefaults()
      return userDefaults.stringForKey("info") ?? ""
    }
  }
  
  /// 邮箱
  static var email: String {
    set{
      UserDefaultsTool.save(newValue, key: "email")
    }
    get{
      let userDefaults = NSUserDefaults.standardUserDefaults()
      return userDefaults.stringForKey("email") ?? ""
    }
  }
  
  /// 性别
  static var sex: Int {
    set{
      UserDefaultsTool.save(newValue, key: "gender")
    }
    get{
      let userDefaults = NSUserDefaults.standardUserDefaults()
      return userDefaults.integerForKey("gender") ?? 0
    }
  }
  
  /// 性别
  static var birthday: String {
    set{
      UserDefaultsTool.save(newValue, key: "birthday")
    }
    get{
      let userDefaults = NSUserDefaults.standardUserDefaults()
      return userDefaults.stringForKey("birthday") ?? ""
    }
  }
  
  /*************************************************/
  
  /// app进入后台的时间
  static var enterBackgroundDate: Double {
    set{
      UserDefaultsTool.save(newValue, key: "enterBackgroundDate")
    }
    get{
      let userDefaults = NSUserDefaults.standardUserDefaults()
      return userDefaults.doubleForKey("enterBackgroundDate") ?? 0
    }
  }
  
  /// 首次启动
  static var isFirstLaunch: Bool {
    set {
      UserDefaultsTool.save(newValue, key: "isFirstLaunch")
    }
    get {
      let userDefaults = NSUserDefaults.standardUserDefaults()
      return userDefaults.boolForKey("isFirstLaunch") ?? false
    }
  }
  
  
  static var userMobile: String {
    set {
      UserDefaultsTool.save(newValue, key: "userMobile")
    }
    get {
      let userDefaults = NSUserDefaults.standardUserDefaults()
      return userDefaults.stringForKey("userMobile") ?? ""
    }
  }
  
  ///Token
  static var userToken: String {
    set {
      UserDefaultsTool.save(newValue, key: "userToken")
    }
    get {
      let userDefaults = NSUserDefaults.standardUserDefaults()
      return userDefaults.stringForKey("userToken") ?? ""
    }
  }
  
  /// QiNiuToken
  static var qiniuToken: String {
    set {
      UserDefaultsTool.save(newValue, key: "qiniuToken")
    }
    get {
      let userDefaults = NSUserDefaults.standardUserDefaults()
      return userDefaults.stringForKey("qiniuToken") ?? ""
    }
  }
  
  static func save(obj: AnyObject, key: String) {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    userDefaults.setObject(obj, forKey: key)
    userDefaults.synchronize()
  }
  
  static func cleanUserInfo() {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    userDefaults.removeObjectForKey("userToken")
    userDefaults.removeObjectForKey("qiniuToken")
    userDefaults.removeObjectForKey("userName")
    userDefaults.removeObjectForKey("headerData")
    userDefaults.removeObjectForKey("userMobile")
  }
  
  static func isLogin() -> Bool {
    let token = UserDefaultsTool.userToken
    return !token.isEmpty
  }
}

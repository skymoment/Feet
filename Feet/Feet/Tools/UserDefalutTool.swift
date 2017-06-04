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
      UserDefaultsTool.save(newValue as AnyObject, key: "userName")
    }
    get{
      let userDefaults = UserDefaults.standard
      return userDefaults.string(forKey: "userName") ?? ""
    }
  }
  
  /// 用户头像
  static var headerData: Data? {
    set{
      UserDefaultsTool.save(newValue! as AnyObject, key: "headerData")
    }
    get{
      let userDefaults = UserDefaults.standard
      userDefaults.data(forKey: "headerData")
      return userDefaults.data(forKey: "headerData")
    }
  }
  
  /// 签名
  static var sign: String {
    set{
      UserDefaultsTool.save(newValue as AnyObject, key: "info")
    }
    get{
      let userDefaults = UserDefaults.standard
      return userDefaults.string(forKey: "info") ?? ""
    }
  }
  
  /// 邮箱
  static var email: String {
    set{
      UserDefaultsTool.save(newValue as AnyObject, key: "email")
    }
    get{
      let userDefaults = UserDefaults.standard
      return userDefaults.string(forKey: "email") ?? ""
    }
  }
  
  /// 性别
  static var sex: Int {
    set{
      UserDefaultsTool.save(newValue as AnyObject, key: "gender")
    }
    get{
      let userDefaults = UserDefaults.standard
      return userDefaults.integer(forKey: "gender") ?? 0
    }
  }
  
  /// 生日
  static var birthday: String {
    set{
      UserDefaultsTool.save(newValue as AnyObject, key: "birthday")
    }
    get{
      let userDefaults = UserDefaults.standard
      return userDefaults.string(forKey: "birthday") ?? ""
    }
  }
  
  /*************************************************/
  
  /// app进入后台的时间
  static var enterBackgroundDate: Double {
    set{
      UserDefaultsTool.save(newValue as AnyObject, key: "enterBackgroundDate")
    }
    get{
      let userDefaults = UserDefaults.standard
      return userDefaults.double(forKey: "enterBackgroundDate") 
    }
  }
  
  /// 首次启动
  static var isFirstLaunch: Bool {
    set {
      UserDefaultsTool.save(newValue as AnyObject, key: "isFirstLaunch")
    }
    get {
      let userDefaults = UserDefaults.standard
      return userDefaults.bool(forKey: "isFirstLaunch") 
    }
  }
  
  
  static var userMobile: String {
    set {
      UserDefaultsTool.save(newValue as AnyObject, key: "userMobile")
    }
    get {
      let userDefaults = UserDefaults.standard
      return userDefaults.string(forKey: "userMobile") ?? ""
    }
  }
  
  ///Token
  static var userToken: String {
    set {
      UserDefaultsTool.save(newValue as AnyObject, key: "userToken")
    }
    get {
      let userDefaults = UserDefaults.standard
      return userDefaults.string(forKey: "userToken") ?? ""
    }
  }
  
  /// QiNiuToken
  static var qiniuToken: String {
    set {
      UserDefaultsTool.save(newValue as AnyObject, key: "qiniuToken")
    }
    get {
      let userDefaults = UserDefaults.standard
      return userDefaults.string(forKey: "qiniuToken") ?? ""
    }
  }
  
  static func save(_ obj: AnyObject, key: String) {
    let userDefaults = UserDefaults.standard
    userDefaults.set(obj, forKey: key)
    userDefaults.synchronize()
  }
  
  static func cleanUserInfo() {
    let userDefaults = UserDefaults.standard
    userDefaults.removeObject(forKey: "userToken")
    userDefaults.removeObject(forKey: "qiniuToken")
    userDefaults.removeObject(forKey: "userName")
    userDefaults.removeObject(forKey: "headerData")
    userDefaults.removeObject(forKey: "userMobile")
    userDefaults.removeObject(forKey: "email")
    userDefaults.removeObject(forKey: "birthday")
    userDefaults.removeObject(forKey: "info")
  }
  
  static func saveInfo(_ model: UserModel) {
    UserDefaultsTool.userToken = model.token
    UserDefaultsTool.userName = model.nickName
    UserDefaultsTool.userMobile = model.phone
    UserDefaultsTool.email = model.email
    UserDefaultsTool.sex = model.gender
    UserDefaultsTool.birthday = model.birthday
  }
  
  static func isLogin() -> Bool {
    let token = UserDefaultsTool.userToken
    return !token.isEmpty
  }
}

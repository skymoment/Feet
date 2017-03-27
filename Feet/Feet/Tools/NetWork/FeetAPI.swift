//
//  FeetAPI.swift
//  Feet
//
//  Created by zhenyu on 10/29/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

// eg: //http://115.28.110.10:8080/feet/user/login

let environment: String = {
//  let defalutDomain = "http://115.28.110.10:8080"
  let defalutDomain = "http://www.skymoment.cn"
  return defalutDomain
}()

let codeImaegURL = environment + "/feet/captcha"

protocol Subpath {
  static func generatePath(path: String) -> String
}

extension Subpath {
  static func generatePath(path: String) -> String {
    let path = "\(environment)/feet/\(String(self).lowercaseString)/\(path)"
    return path
  }
}


struct FeetAPI {
  
  // MAKR: - 用户
  struct User: Subpath {
    /// 获取短信验证码
    static let getPhoneSmsCode = User.generatePath("getPhoneSmsCode")
    /// 登录接口
    static let login = User.generatePath("login")
    /// 更新用户信息
    static let updateUserInfo = User.generatePath("updateUserInfo")
  }
  
  // MAKR: - 新版登录接口
  struct NewUser: Subpath {
    // 登录接口
    static let login = NewUser.generatePath("login")
    // 注册人接口
    static let regist = NewUser.generatePath("regist")
    // 退出登录
    static let logOut = NewUser.generatePath("logout")
  }
  
  // MARK: - 七牛令牌
  struct ImgToken: Subpath {
    static let index = ImgToken.generatePath("index")
    static let a = ImgToken.generatePath("a")
  }
  
  // MARK: - Feet
  struct Feet: Subpath {
    /// 获取 Feet 列表
    static let feet = Feet.generatePath("feet")
    /// 获取 Feet 详情
    static let getInfo = Feet.generatePath("getInfo")
    /// 发布 Feet
    static let add = Feet.generatePath("add")
    /// 名言
    static let ow = Feet.generatePath("ow")
    /// 图形验证码
    static let captcha =  Feet.generatePath("captcha")
  }
  
  // MARK: - 评论
  struct Comment: Subpath {
    /// 评论
    static let add = Comment.generatePath("add")
    /// 点赞
    static let zan = Comment.generatePath("zan")
  }
}

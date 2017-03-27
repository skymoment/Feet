//
//  LoginNetTool.swift
//  Feet
//
//  Created by 王振宇 on 7/3/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation
import SwiftyJSON

struct LoginNetTool {
  
  /**
   退出登录
   
   - parameter params:     参数
   - parameter completion: 回调
   */
  static func logOut(completion: (Promise<String>)->()) {
    let url = FeetAPI.NewUser.logOut
    
    func parseJson(json: JSON) -> Promise<String> {
      if json["code"].intValue == 12000 {
        return Promise.Success(String("退出登录成功"))
      } else {
        return Promise.Error(MyError(error: "退出登录失败"))
      }
    }
    
    ApiClient.fetch(.POST, URLString: url) { promiseJSON in
      let result = promiseJSON.then(parseJson)
      completion(result)
    }
  }
  
  /**
   获取短信验证码
   
   - parameter params:     参数
   - parameter completion: 回调
   */
  static func gainCode(params: [String:String],completion:(Promise<String>) -> ()) {
    //    let url = "http://115.28.110.10:8080/feet/user/getPhoneSmsCode"
    let url = FeetAPI.User.getPhoneSmsCode
    
    func parseJson(json: JSON) -> Promise<String>{
      if json["code"].intValue == 12000 {
        return Promise.Success(String("发送成功"))
      } else {
        return Promise.Error(MyError(error: "短信发送失败"))
      }
    }
    
    ApiClient.fetch(.POST, URLString: url,paramters: params) { promiseJSON in
      let result = promiseJSON.then(parseJson)
      completion(result)
    }
  }
  
  
  /**
   登录
   
   - parameter params:    参数
   - parameter completon: 回调
   */
  static func logIn(params: [String: String],completon:(Promise<UserModel>) ->()) {
    //    let url = "http://115.28.110.10:8080/feet/user/login"
    let url = FeetAPI.User.login
    func parseJson(json: JSON) -> Promise<UserModel>{
      if json["code"].intValue == 12000 {
        return Promise {UserModel(json: json)}
      } else {
        return Promise.Error(MyError(error: json["msg"].stringValue))
      }
    }
    
    ApiClient.fetch(.POST, URLString: url,paramters: params) { promiseJSON in
      let result = promiseJSON.then(parseJson)
      debugPrint(result)
      completon(result)
    }
  }
  
  
  /**
   新登录
   
   - parameter params:    参数
   - parameter completon: 回调
   */
  static func newLogin(params: [String: String],completon:(Promise<UserModel>) ->()) {
    //    let url = "http://115.28.110.10:8080/feet/user/login"
    let url = FeetAPI.NewUser.login
    func parseJson(json: JSON) -> Promise<UserModel>{
      if json["code"].intValue == 12000 {
        return Promise {UserModel(json: json)}
      } else {
        return Promise.Error(MyError(error: json["msg"].stringValue))
      }
    }
    
    ApiClient.fetch(.POST, URLString: url,paramters: params) { promiseJSON in
      let result = promiseJSON.then(parseJson)
      debugPrint(result)
      completon(result)
    }
  }
  
  
  /**
   注册
   - parameter params:    参数
   - parameter completon: 回调
   */
  static func regist(params: [String: String],completon:(Promise<UserModel>) ->()) {
    //    let url = "http://115.28.110.10:8080/feet/user/login"
    let url = FeetAPI.NewUser.regist
    func parseJson(json: JSON) -> Promise<UserModel>{
      if json["code"].intValue == 12000 {
        return Promise {UserModel(json: json)}
      } else {
        return Promise.Error(MyError(error: json["msg"].stringValue))
      }
    }
    
    ApiClient.fetch(.POST, URLString: url,paramters: params) { promiseJSON in
      let result = promiseJSON.then(parseJson)
      debugPrint(result)
      completon(result)
    }
  }
}

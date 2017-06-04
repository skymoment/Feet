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
  static func logOut(_ completion: @escaping (Promise<String>)->()) {
    let url = FeetAPI.NewUser.logOut
    
    func parseJson(_ json: JSON) -> Promise<String> {
      if json["code"].intValue == 12000 {
        return Promise.success(String("退出登录成功"))
      } else {
        return Promise.error(MyError(error: "退出登录失败"))
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
  static func gainCode(_ params: [String:String],completion:@escaping (Promise<String>) -> ()) {
    //    let url = "http://115.28.110.10:8080/feet/user/getPhoneSmsCode"
    let url = FeetAPI.User.getPhoneSmsCode
    
    func parseJson(_ json: JSON) -> Promise<String>{
      if json["code"].intValue == 12000 {
        return Promise.success(String("发送成功"))
      } else {
        return Promise.error(MyError(error: "短信发送失败"))
      }
    }
    
    ApiClient.fetch(.POST, URLString: url,paramters: params as [String : AnyObject]?) { promiseJSON in
      let result = promiseJSON.then(parseJson)
      completion(result)
    }
  }
  
  
  /**
   登录
   
   - parameter params:    参数
   - parameter completon: 回调
   */
  static func logIn(_ params: [String: String],completon:@escaping (Promise<UserModel>) ->()) {
    //    let url = "http://115.28.110.10:8080/feet/user/login"
    let url = FeetAPI.User.login
    func parseJson(_ json: JSON) -> Promise<UserModel>{
      if json["code"].intValue == 12000 {
        return Promise {UserModel(json: json)}
      } else {
        return Promise.error(MyError(error: json["msg"].stringValue))
      }
    }
    
    ApiClient.fetch(.POST, URLString: url,paramters: params as [String : AnyObject]?) { promiseJSON in
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
  static func newLogin(_ params: [String: String],completon:@escaping (Promise<UserModel>) ->()) {
    //    let url = "http://115.28.110.10:8080/feet/user/login"
    let url = FeetAPI.NewUser.login
    func parseJson(_ json: JSON) -> Promise<UserModel>{
      if json["code"].intValue == 12000 {
        return Promise {UserModel(json: json)}
      } else {
        return Promise.error(MyError(error: json["msg"].stringValue))
      }
    }
    
    ApiClient.fetch(.POST, URLString: url,paramters: params as [String : AnyObject]?) { promiseJSON in
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
  static func regist(_ params: [String: String],completon:@escaping (Promise<UserModel>) ->()) {
    //    let url = "http://115.28.110.10:8080/feet/user/login"
    let url = FeetAPI.NewUser.regist
    func parseJson(_ json: JSON) -> Promise<UserModel>{
      if json["code"].intValue == 12000 {
        return Promise {UserModel(json: json)}
      } else {
        return Promise.error(MyError(error: json["msg"].stringValue))
      }
    }
    
    ApiClient.fetch(.POST, URLString: url,paramters: params as [String : AnyObject]?) { promiseJSON in
      let result = promiseJSON.then(parseJson)
      debugPrint(result)
      completon(result)
    }
  }
}

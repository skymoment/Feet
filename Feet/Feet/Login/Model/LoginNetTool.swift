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
   获取短信验证码
   
   - parameter params:     参数
   - parameter completion: 回调
   */
  static func gainCode(params: [String:String],completion:(Promise<String>) -> ()) {
    let url = "http://115.28.110.10:8080/feet/user/getPhoneSmsCode"
    
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
    let url = "http://115.28.110.10:8080/feet/user/login"
    
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

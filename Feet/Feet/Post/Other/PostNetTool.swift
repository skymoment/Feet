//
//  PostNetTool.swift
//  Feet
//
//  Created by 王振宇 on 7/10/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation
import SwiftyJSON
struct PostNetTool {
  
  /**
   获取七牛Token
   */
  static func qiuNiuToken(compeltion: (() -> ())? = nil){
    let url = FeetAPI.ImgToken.a
    
    func parseJson(json: JSON) -> Promise<String>{
      if json["code"].intValue == 12000 {
        UserDefaultsTool.qiniuToken = json["data","token"].stringValue
        debugPrint("================" + json["data","token"].stringValue)
        return Promise.Success("获取成功")
      } else {
        return Promise.Error(MyError(error: json["msg"].stringValue))
      }
    }
    
    ApiClient.fetch(.POST, URLString: url,paramters: ["feetToken": UserDefaultsTool.userToken]) { promiseJSON in
      let result = promiseJSON.then(parseJson)
      debugPrint(result)
      if let c = compeltion {
        c()
      }
    }
  }
  
  
  /**
   发布 Feet
   
   - parameter params:    参数
   - parameter completon: 回调
   */
  static func post(params: [String: String],completon:(Promise<String>) ->()) {
    
    debugPrint(params["feeToken"])
//    let url = "http://115.28.110.10:8080/feet/feet/add"
    let url = FeetAPI.Feet.add
    
    func parseJson(json: JSON) -> Promise<String>{
      if json["code"].intValue == 12000 {
        return Promise.Success("发送成功")
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

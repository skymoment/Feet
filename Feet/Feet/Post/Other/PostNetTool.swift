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
  static func qiuNiuToken(_ compeltion: (() -> ())? = nil){
    let url = FeetAPI.ImgToken.a
    
    func parseJson(_ json: JSON) -> Promise<String>{
      if json["code"].intValue == 12000 {
        UserDefaultsTool.qiniuToken = json["data","token"].stringValue
        debugPrint("================" + json["data","token"].stringValue)
        return Promise.success("获取成功")
      } else {
        return Promise.error(MyError(error: json["msg"].stringValue))
      }
    }
    
    ApiClient.fetch(.POST, URLString: url,paramters: ["feetToken": UserDefaultsTool.userToken as AnyObject]) { promiseJSON in
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
  static func post(_ params: [String: String],completon:@escaping (Promise<String>) ->()) {
    
    debugPrint(params["feeToken"])
//    let url = "http://115.28.110.10:8080/feet/feet/add"
    let url = FeetAPI.Feet.add
    
    func parseJson(_ json: JSON) -> Promise<String>{
      if json["code"].intValue == 12000 {
        return Promise.success("发送成功")
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

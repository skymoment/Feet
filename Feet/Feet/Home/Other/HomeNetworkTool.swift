//
//  HomeNetworkTool.swift
//  Feet
//
//  Created by 王振宇 on 7/10/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation
import SwiftyJSON
struct HomeNetworkTool {
  
  /**
   获取 Feets
   */
  static func getFeet(_ params: [String: String],completon:@escaping (Promise<FeetModels>) ->()) {
    
    let url = FeetAPI.Feet.feet
    debugPrint(url)
    debugPrint(UserDefaultsTool.userToken)
    func parseJson(_ json: JSON) -> Promise<FeetModels>{
      if json["code"].intValue == 12000 {
        let feetModels = FeetModels(json: json["data"])
        return Promise.success(feetModels)
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
   *  Feet 详情
   */
  static func getFeetDetail(_ params: [String: String],completon:@escaping (Promise<FeetDetailModel>) ->()) {
    let url = FeetAPI.Feet.getInfo
    
    func parseJson(_ json: JSON) -> Promise<FeetDetailModel>{
      if json["code"].intValue == 12000 {
        let model = FeetDetailModel(json: json)
        return Promise.success(model)
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
   评论
   */
  static func commentFeet(_ params: [String: String],completon:@escaping (Promise<Void>) ->()) {
    let url = FeetAPI.Comment.add
    
    func parseJson(_ json: JSON) -> Promise<Void>{
      if json["code"].intValue == 12000 {
        return Promise.success()
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
   点赞
   */
  static func zanFeet(_ params: [String: String],completon:@escaping (Promise<Void>) ->()) {
    let url = FeetAPI.Comment.zan
    
    func parseJson(_ json: JSON) -> Promise<Void>{
      if json["code"].intValue == 12000 {
        return Promise.success()
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
   每日一句
   */
  static func owFeet(_ completon:@escaping (Promise<OWModel>) ->()) {
    let url = FeetAPI.Feet.ow
    
    func parseJson(_ json: JSON) -> Promise<OWModel>{
      if json["code"].intValue == 12000 {
        let model = OWModel(json: json["data"])
        return Promise.success(model)
      } else {
        return Promise.error(MyError(error: json["msg"].stringValue))
      }
    }
    
    ApiClient.fetch(.POST, URLString: url) { promiseJSON in
      let result = promiseJSON.then(parseJson)
      debugPrint(result)
      completon(result)
    }
  }
}

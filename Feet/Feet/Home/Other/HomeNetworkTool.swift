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
  static func getFeet(params: [String: String],completon:(Promise<FeetModels>) ->()) {
    
    let url = FeetAPI.Feet.feet
    debugPrint(url)
    debugPrint(UserDefaultsTool.userToken)
    func parseJson(json: JSON) -> Promise<FeetModels>{
      if json["code"].intValue == 12000 {
        let feetModels = FeetModels(json: json["data"])
        return Promise.Success(feetModels)
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
   *  Feet 详情
   */
  static func getFeetDetail(params: [String: String],completon:(Promise<FeetDetailModel>) ->()) {
    let url = FeetAPI.Feet.getInfo
    
    func parseJson(json: JSON) -> Promise<FeetDetailModel>{
      if json["code"].intValue == 12000 {
        let model = FeetDetailModel(json: json)
        return Promise.Success(model)
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
   评论
   */
  static func commentFeet(params: [String: String],completon:(Promise<Void>) ->()) {
    let url = FeetAPI.Comment.add
    
    func parseJson(json: JSON) -> Promise<Void>{
      if json["code"].intValue == 12000 {
        return Promise.Success()
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
   点赞
   */
  static func zanFeet(params: [String: String],completon:(Promise<Void>) ->()) {
    let url = FeetAPI.Comment.zan
    
    func parseJson(json: JSON) -> Promise<Void>{
      if json["code"].intValue == 12000 {
        return Promise.Success()
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
   每日一句
   */
  static func owFeet(completon:(Promise<OWModel>) ->()) {
    let url = FeetAPI.Comment.zan
    
    func parseJson(json: JSON) -> Promise<OWModel>{
      if json["code"].intValue == 12000 {
        let model = OWModel(json: json["data"])
        return Promise.Success(model)
      } else {
        return Promise.Error(MyError(error: json["msg"].stringValue))
      }
    }
    
    ApiClient.fetch(.POST, URLString: url) { promiseJSON in
      let result = promiseJSON.then(parseJson)
      debugPrint(result)
      completon(result)
    }
  }
}

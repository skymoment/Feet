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
  static func getFeet(params: [String: String],completon:(Promise<[FeetModel]>) ->()) {
    
    let url = FeetAPI.Feet.feet
    debugPrint(url)
    debugPrint(UserDefaultsTool.userToken)
    func parseJson(json: JSON) -> Promise<[FeetModel]>{
      if json["code"].intValue == 12000 {
        var models = [FeetModel]()
        for model in json["data","list"].arrayValue {
          models.append(FeetModel(json: model))
        }
        return Promise.Success(models)
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
  static func getFeetDetail(params: [String: String],completon:(Promise<[FeetModel]>) ->()) {
    let url = FeetAPI.Feet.getInfo
    
    ApiClient.fetch(.POST, URLString: url,paramters: params) { promiseJSON in
      
    }
  }
  
  
  /**
   评论
   */
  static func commentFeet(params: [String: String],completon:(Promise<[FeetModel]>) ->()) {
    let url = FeetAPI.Comment.add
    
    ApiClient.fetch(.POST, URLString: url,paramters: params) { promiseJSON in
      
    }
  }
  
  /**
   点赞
   */
  static func zanFeet(params: [String: String],completon:(Promise<[FeetModel]>) ->()) {
    let url = FeetAPI.Comment.zan
    ApiClient.fetch(.POST, URLString: url,paramters: params) { promiseJSON in
      
    }
  }
}

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
  static func post(params: [String: String],completon:(Promise<[FeetModel]>) ->()) {
    
    let url = "http://115.28.110.10:8080/feet/feet"
    
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
}

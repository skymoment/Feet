//
//  UpdateUserInfoNetTool.swift
//  Feet
//
//  Created by zhenyu on 11/6/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation
import SwiftyJSON

struct UserNetworkTool {
  
  /**
    * 用户信息：更新、获取
    */
  static func userInfo(params: [String: String], completion: (Promise<UserInfoModel>) -> ()) {
    let url = FeetAPI.User.updateUserInfo
    
    func parseJson(json: JSON) -> Promise<UserInfoModel> {
      if json["code"].intValue == 120000 {
        let model = UserInfoModel(json: json)
        return Promise.Success(model)
      } else {
        return Promise.Error(MyError(error: json["msg"].stringValue))
      }
    }
    
    ApiClient.fetch(.POST, URLString: url) { (promiseJSON) in
      let result = promiseJSON.then(parseJson)
      debugPrint(result)
      completion(result)
    }
  }
}

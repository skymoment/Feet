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
  static func userInfo(_ params: [String: String], completion: @escaping (Promise<UserInfoModel>) -> ()) {
    let url = FeetAPI.User.updateUserInfo //FeetAPI.User.updateUserInfo
    
    func parseJson(_ json: JSON) -> Promise<UserInfoModel> {
      if json["code"].intValue == 12000 {
        let model = UserInfoModel(json: json)
        return Promise.success(model)
      } else {
        return Promise.error(MyError(error: json["msg"].stringValue))
      }
    }
    
    ApiClient.fetch(.POST, URLString: url, paramters: params as [String : AnyObject]?) { (promiseJSON) in
      let result = promiseJSON.then(parseJson)
      debugPrint(result)
      completion(result)
    }
  }
}

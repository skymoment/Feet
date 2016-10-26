//
//  UserModel.swift
//  Feet
//
//  Created by 王振宇 on 7/3/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation
import SwiftyJSON
class UserModel: NSObject {
  var id  = 0
  var nickName = ""
  var phone = ""
  var image = ""
  var token = ""
  
  init(json: JSON) {
    id = json["data","id"].intValue
    nickName = json["data","nickName"].stringValue
    phone = json["data","phone"].stringValue
    image = json["data","image"].stringValue
    token = json["data","token"].stringValue
  }
}

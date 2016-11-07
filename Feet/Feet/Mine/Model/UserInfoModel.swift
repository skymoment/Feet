//
//  UserInfoModel.swift
//  Feet
//
//  Created by zhenyu on 11/6/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit
import SwiftyJSON

//"birthday": "1992-01-28",
//"image": "f56w4ef6",
//"gender": 1,
//"phone": 13681774924,
//"nickname": "weizhikang",
//"id": 8,
//"email": "313114925@qq.com",
//"registerDate": 1466236439,
//"info": "爱你一棒槌2"

class UserInfoModel: NSObject {
  
  var id: Int = 0
  var image: String = ""
  var birthday: String = ""
  var gender: Int = 0
  var phone: Int = 0
  var nickname: String = ""
  var email: String = ""
  var registerDate: Int = 0
  var info: String = ""
  
  init(json: JSON) {
    id = json["data","id"].intValue
    image = json["data","image"].stringValue
    birthday = json["data","birthday"].stringValue
    gender = json["data","gender"].intValue
    phone = json["data","phone"].intValue
    nickname = json["data","nickname"].stringValue
    email = json["data","email"].stringValue
    registerDate = json["data","registerDate"].intValue
    info = json["data","info"].stringValue
  }
}

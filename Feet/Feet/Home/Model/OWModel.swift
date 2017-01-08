//
//  OWModel.swift
//  Feet
//
//  Created by zhenyu on 17/1/5.
//  Copyright © 2017年 王振宇. All rights reserved.
//

import UIKit
import SwiftyJSON

class OWModel: NSObject {
//  "name": "民谚",------名言出处
//  "day": 12,---------------上线天数
//  "content": "看人下菜碟"------名言
  var name = ""
  var day = ""
  var content = ""
  
  init(json: JSON) {
    name = json["name"].stringValue
    day = json["day"].stringValue
    content = json["content"].stringValue
  }
}

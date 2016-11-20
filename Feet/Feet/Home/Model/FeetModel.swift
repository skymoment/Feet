//
//  FeetModel.swift
//  Feet
//
//  Created by 王振宇 on 6/1/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation
import SwiftyJSON

class FeetModel: NSObject {
  
//  "city": "Beijing",
//  "mood": 1,
//  "likeCount": 0,
//  "id": 4,
//  "time": "2016-07-04 21:47:09",
//  "userId": 8,
//  "pics": null,
//  "content": "kflwjlekfjlw",
//  "lookCount": 0

  var id:Int = 0
  var userId:Int = 0
  var city:String = ""
  var mood:Int = 0
  var likeCount:Int = 0
  var lookCount:Int = 0
  var time:String = ""
  var pics = [String]()
  var content:String = ""

  init(json: JSON) {
    id = json["id"].intValue
    userId = json["userId"].intValue
    city = json["city"].stringValue
    mood = json["mood"].intValue
    likeCount = json["likeCount"].intValue
    lookCount = json["lookCount"].intValue
    time = json["time"].stringValue
    let pictrues = json["pics"].stringValue
    
    if !pictrues.isEmpty {
      let p = pictrues.componentsSeparatedByString(",")
      pics.appendContentsOf(p)
    }
    
    content = json["content"].stringValue
  }
}


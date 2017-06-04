//
//  FeetDetailModel.swift
//  Feet
//
//  Created by zhenyu on 11/13/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit
import SwiftyJSON

class FeetInfo: NSObject {
  var mood:Int = 0
  var city:String = ""
  var likeCount: Int = 0
  var id: Int = 0
  var time: String = ""
  var userId = ""
  var pics = [String]()
  var content: String = ""
  var lookCount:Int = 0
  var selflike:Int = 1
  var nickname:String = ""
  var image: String = ""
  
  init(json: JSON) {
    mood = json["mood"].intValue
    city = json["city"].stringValue
    likeCount = json["likeCount"].intValue
    id = json["id"].intValue
    time = json["time"].stringValue
    userId = json["userId"].stringValue
    content = json["content"].stringValue
    lookCount = json["lookCount"].intValue
    selflike = json["selflike"].intValue
    nickname = json["nickname"].stringValue
    image = json["image"].stringValue
    
    let pictures = json["pics"].stringValue
    if !pictures.isEmpty {
      if pictures.contains(",") {
        let p = pictures.components(separatedBy: ",")
        pics.append(contentsOf: p)
      } else {
        pics.append(pictures)
      }
    }
  }
}

class CommentInfo: NSObject {
  var replyUserId:Int = 0
  var feetId:Int = 0
  var replyUserName:String = ""
  var nickname:String = ""
  var id:Int = 0
  var userId:Int = 0
  var time:String = ""
  var content:String = ""
  
  init(json: JSON) {
    replyUserId = json["replyUserId"].intValue
    feetId = json["feetId"].intValue
    replyUserName = json["replyUserName"].stringValue
    nickname = json["nickname"].stringValue
    id = json["id"].intValue
    userId = json["userId"].intValue
    time = json["time"].stringValue
    content = json["content"].stringValue
  }
}

class FeetDetailModel: NSObject {
  var commentInfo = [CommentInfo]()
  var feetInfo: FeetInfo!
  
  init(json: JSON) {
    let comments = json["data","commentInfo"].arrayValue
    for comment in comments {
      commentInfo.append(CommentInfo(json: comment))
    }
    
    feetInfo = FeetInfo(json: json["data","feetInfo"])
  }
}

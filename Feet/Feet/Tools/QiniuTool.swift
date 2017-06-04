//
//  QiniuTool.swift
//  Feet
//
//  Created by 王振宇 on 7/13/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation
import Qiniu

struct QiniuTool {
//    NSString *token = @"从服务端SDK获取";
//    QNUploadManager *upManager = [[QNUploadManager alloc] init];
//    NSData *data = [@"Hello, World!" dataUsingEncoding : NSUTF8StringEncoding];
//    [upManager putData:data key:@"hello" token:token
//    complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//    NSLog(@"%@", info);
//    NSLog(@"%@", resp);
//    } option:nil];
  
  static func upLoadImage(_ filePath: String, compeletion: @escaping (String) ->()) {
    let token = UserDefaultsTool.qiniuToken
    let upLoadManger = QNUploadManager()
    upLoadManger?.putFile(filePath, key: nil, token: token, complete: { (info, key, response) in
      debugPrint("info===\(info)")
      debugPrint("key === \(key)")
      debugPrint("response ==== \(response)")
      let key = (response?["key"] as! String)
      compeletion(key)
      }, option: nil)
  }
  
  static func upLoadImages(_ images:[String],completion: @escaping (_ progress: Double, _ keys: [String]) -> (),failtrue: () -> ()) {
    
    /****************/
    for image in images  {
      debugPrint("image: \(image)")
    }
    /****************/

    let token = UserDefaultsTool.qiniuToken
    let upLoadManger = QNUploadManager()
    var keys = [String]()
    for (index,image) in images.enumerated() {
      upLoadManger?.putFile(image, key: nil, token: token, complete: { (info, key, response) in
        debugPrint("info===\(info)")
        debugPrint("key === \(key)")
        debugPrint("response ==== \(response)")
        debugPrint("response ==== \(response?["key"]!)")
        keys.append(response?["key"] as! String)
        let percent = Double(index + 1) / Double(images.count)
        completion(percent, keys)
        }, option: nil)
    }
  }
}

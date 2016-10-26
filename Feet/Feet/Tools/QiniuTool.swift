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
  //  NSString *token = @"从服务端SDK获取";
  //  QNUploadManager *upManager = [[QNUploadManager alloc] init];
  //  NSData *data = [@"Hello, World!" dataUsingEncoding : NSUTF8StringEncoding];
  //  [upManager putData:data key:@"hello" token:token
  //  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
  //  NSLog(@"%@", info);
  //  NSLog(@"%@", resp);
  //  } option:nil];
  
  static func upLoadImage(filePath: String) {
    let token = UserDefaultsTool.qiniuToken
    let upLoadManger = QNUploadManager()
    upLoadManger.putFile(filePath, key: nil, token: token, complete: { (info, key, response) in
      debugPrint("info===\(info)")
      debugPrint("key === \(key)")
      debugPrint("response ==== \(response)")
      }, option: nil)
  }
  
  static func upLoadImages(images:[String],completion: (progress: Double) -> (),failtrue: () -> ()) {
    let token = UserDefaultsTool.qiniuToken
    let upLoadManger = QNUploadManager()
    
    for (index,image) in images.enumerate() {
      upLoadManger.putFile(image, key: nil, token: token, complete: { (info, key, response) in
        debugPrint("info===\(info)")
        debugPrint("key === \(key)")
        debugPrint("response ==== \(response)")
        
        let percent = Double(index) / Double(images.count)
        completion(progress: percent)
        }, option: nil)
    }
  }
}
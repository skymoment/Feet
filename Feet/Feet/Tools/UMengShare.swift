//
//  UMengShare.swift
//  Feet
//
//  Created by 王振宇 on 7/3/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation

enum ShareDataType {
  // QQ
  case qq
  // 微信
  case wc
  // 朋友圈
  case wct
  // 微博
  case wb
}

struct UmengShare {
  
  static func share(_ title: String, content: String,url: String, imageURL: String, type: String, dataType: ShareDataType) {
    
    UMSocialData.default().extConfig.title = title
    
    switch dataType {
    case .qq:
      UMSocialData.default().extConfig.qqData.url = url
    case .wc:
      UMSocialData.default().extConfig.wechatSessionData.url  = url
    case .wct:
      UMSocialData.default().extConfig.wechatTimelineData.url = url
    default:
      break
    }
    
//    let resource = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: imageURL)
    
    
//      - (void)postSNSWithTypes:(NSArray *)platformTypes
//    content:(NSString *)content
//    image:(id)image
//    location:(CLLocation *)location
//    urlResource:(UMSocialUrlResource *)urlResource
//    presentedController:(UIViewController *)presentedController
//    completion:(UMSocialDataServiceCompletion)completion;

    
    
//    let service = UMSocialDataService.defaultDataService()
   
  }
  
}

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
  case QQ
  // 微信
  case WC
  // 朋友圈
  case WCT
  // 微博
  case WB
}

struct UmengShare {
  
  static func share(title: String, content: String,url: String, imageURL: String, type: String, dataType: ShareDataType) {
    
    UMSocialData.defaultData().extConfig.title = title
    
    switch dataType {
    case .QQ:
      UMSocialData.defaultData().extConfig.qqData.url = url
    case .WC:
      UMSocialData.defaultData().extConfig.wechatSessionData.url  = url
    case .WCT:
      UMSocialData.defaultData().extConfig.wechatTimelineData.url = url
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
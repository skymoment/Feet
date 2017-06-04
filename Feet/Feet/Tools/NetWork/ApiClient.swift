//
//  ApiClient.swift
//  SwiftCocoa
//
//  Created by 王振宇 on 5/12/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
enum HttpRequestType: String {
  case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}


struct ApiClient {
  
//  //生成header信息，每个请求都必须带的
//  fileprivate static func generationHeaders() -> [String : String] {
//    let headers = [
//      "feeToken": UserDefaultsTool.userToken
////      "X-App-Id": "",
////      "X-Requested-With": "XMLHttpRequest",
////      "HTTP_X_APP_TYPE": "2",
////      "X-Udid" : "",
////      "X-User-Phone-Brand" : "",
////      "X-User-System" : ""
//    ]
//    return headers
//  }
  
  fileprivate static func feetHeaders() -> [String: String] {
    let headers = [
      "X-User-Token": UserDefaultsTool.userToken
//      "X-App-Id": QSQAppId,
//      "X-Requested-With": "XMLHttpRequest",
//      "X-CLIENT-ID": "iOS",
//      "X-Udid" : BasicTool.getUUID(),
//      "X-User-Phone-Brand" : BasicTool.getMobileVersion(),
//      "X-User-System" : BasicTool.getOSVersion()
    ]
    return headers
  }
  
  
  // Request 请求封装
  fileprivate static func alamofireRequest(_ type: HttpRequestType,_ URLString: String, parameters: [String: AnyObject]?) -> Request {
    
    let method = HTTPMethod(rawValue: type.rawValue)!
    let r = request(URLString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: feetHeaders())
    return r
  }
  
  
  static func fetch(_ type: HttpRequestType, URLString url: String, paramters para: [String: AnyObject]? = nil, promise:    @escaping (Promise<JSON>) -> ()){
    let method = HTTPMethod(rawValue: type.rawValue)!
    _ = request(url, method: method, parameters: para, encoding: URLEncoding.default, headers: feetHeaders()).responseJSON(completionHandler: { (response) in
      debugPrint("url === \(url)")
        if let value = response.result.value {
          let json = JSON(value)
          let code = json["code"].intValue
          if code == 14000 {
            LoginService.showLogin()
            let msg = json["msg"].stringValue
            HUD.showError(msg)
            return
          }
  
  
          promise(Promise.success(json))
          debugPrint(json)
          return
        }
        promise(Promise.error(response.result.error!))
    })
//      alamofireRequest(type, url, parameters: para).responseJSON { response in
//      debugPrint("url === \(url)")
//      if let value = response.result.value {
//        let json = JSON(value)
//        let code = json["code"].intValue
//        if code == 14000 {
//          LoginService.showLogin()
//          let msg = json["msg"].stringValue
//          HUD.showError(status: msg)
//          return
//        }
//        
//        
//        promise(Promise.Success(json))
//        debugPrint(json)
//        return
//      }
//      promise(Promise.Error(response.result.error!))
//    }
  }
  
  
  /// 下载图片并获取图片cookie
  static func downLoadImage(_ urlString: String, compeletion: @escaping (Data?, String?) -> ()) {
    let url = URL(string: urlString)
    let request = URLRequest(url: url!)
    NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
      let httpUrlResponse = response as! HTTPURLResponse
      let cookieString = (httpUrlResponse.allHeaderFields as NSDictionary).value(forKey: "Set-Cookie") as? String
      compeletion(data, cookieString)
    }
  }
}

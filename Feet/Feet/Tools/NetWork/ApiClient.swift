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
  
  //生成header信息，每个请求都必须带的
  private static func generationHeaders() -> [String : String] {
    let headers = [
      "feeToken": UserDefaultsTool.userToken
//      "X-App-Id": "",
//      "X-Requested-With": "XMLHttpRequest",
//      "HTTP_X_APP_TYPE": "2",
//      "X-Udid" : "",
//      "X-User-Phone-Brand" : "",
//      "X-User-System" : ""
    ]
    return headers
  }
  
  
  // Request 请求封装
  private static func alamofireRequest(method: Alamofire.Method,_ URLString: URLStringConvertible, parameters: [String: AnyObject]?) -> Request {
    return request(method, URLString, parameters: parameters, encoding: .URL, headers: self.generationHeaders())
  }
  
  
  static func fetch(type: HttpRequestType, URLString url: String, paramters para: [String: AnyObject]? = nil, promise: (Promise<JSON>) -> ()){
    let method = Method(rawValue: type.rawValue)!
    self.alamofireRequest(method, url, parameters: para).responseJSON { response in
      
      if let value = response.result.value {
        let json = JSON(value)
        promise(Promise.Success(json))
        
        debugPrint(json)
        return
      }
      
      promise(Promise.Error(response.result.error!))
    }
  }
}

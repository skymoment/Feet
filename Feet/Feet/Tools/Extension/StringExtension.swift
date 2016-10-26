//
//  StringExtension.swift
//  Feet
//
//  Created by 王振宇 on 7/7/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation

extension String {
  
  /**
   删除空格
   
   - returns: String
   */
  func deleteBlankSpace() -> String{
    let result = self.characters.filter { c in
      return c != " "
      }.reduce("") { (str, c) -> String in
        return str + "\(c)"
    }
    return result
  }
  
  /**
   字符串长度
   
   - returns: length
   */
  func length() -> Int{
    return self.characters.count
  }
}
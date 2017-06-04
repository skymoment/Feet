//
//  UIColorExtension.swift
//  QQT
//
//  Created by 张霄男 on 15/12/22.
//  Copyright © 2015年 qianshengqian.com. All rights reserved.
//

import UIKit

extension UIColor {
  
  /**
   根据给定的16进制颜色代码生成UIColor
   
   - parameter hexString: 6位16进制颜色代码，支持前缀带“#”和"0x"的字符串
   - parameter alpha:     透明度
   
   */
  convenience init(hexString: String, alpha: CGFloat = 1) {
    var hex = hexString.lowercased().replacingOccurrences(of: "#", with: "")
    hex = hex.replacingOccurrences(of: "0x", with: "")
    
    guard hex.characters.count == 6 else {
      self.init(red: 0, green: 0, blue: 0, alpha: alpha)
      return
    }
//    assert(hex.characters.count == 6, "使用不合法的字符串")
    
    let redIndex = hex.characters.index(hex.startIndex, offsetBy: 2)
    let redString = hex.substring(to: redIndex)
    
    let greenRange = Range(hex.characters.index(hex.startIndex, offsetBy: 2)..<hex.characters.index(hex.startIndex, offsetBy: 4))
    let greenString = hex.substring(with: greenRange)
    
    let blueIndex = hex.characters.index(hex.endIndex, offsetBy: -2)
    let blueString = hex.substring(from: blueIndex)
    
    
    var red:UInt32 = 0
    var green:UInt32 = 0
    var blue:UInt32 = 0
    Scanner(string: redString).scanHexInt32(&red)
    Scanner(string: greenString).scanHexInt32(&green)
    Scanner(string: blueString).scanHexInt32(&blue)
    
    self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
    
  }
  
  convenience init(decimalRed: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
    self.init(red: CGFloat(decimalRed) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
  }
}

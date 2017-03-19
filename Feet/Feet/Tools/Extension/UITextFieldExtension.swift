//
//  UITextFieldExtension.swift
//  SwiftCocoa
//
//  Created by 王振宇 on 6/2/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

extension UITextField {
  
  func numberOnly() {
    let number = self.text!
    if number.length() > 0 {
      
      let text = number.characters.filter({ (c) -> Bool in
        if "0123456789".containsString(String(c)) {
          return true
        } else {
          return false
        }
      })
      self.text! = String(text)
      
//            if (self.text?.length)! > 0 {
//              let str = (String(text) as NSString ).substring(with: NSRange(location: 0, length: 1))
//              if str == "0" {
//                self.text! = ""
//              }
//            }
    }
  }
  
  func parseString(spaceStr: String?, numArray: NSArray) -> String? {// 添加空格
    if spaceStr == nil {
      return nil
    }
    let mStr = NSMutableString(string: (spaceStr?.stringByReplacingOccurrencesOfString(" ", withString: ""))!)
    // 遍历数组间隔位数
    for space in numArray {
      if mStr.length > Int(space as! NSNumber) {
        mStr.insertString(" ", atIndex: Int(space as! NSNumber))
      }
    }
    return mStr as String
  }

  
  
  /// text长度
  var length: Int {
    return self.text!.characters.count
  }
  
  /**
   限制textField的输入长度
   
   - parameter textField: textField
   - parameter range:     range
   - parameter string:    string
   - parameter maxLength:  maxLength 默认18
   
   - returns: Bool
   */
  func textMaxLength(textField: UITextField, range: NSRange, string: String, maxLength: Int = 18) -> Bool {
    if textField.text!.characters.count + string.characters.count > maxLength {
      return false
    }
    return true
  }
  
  /**
   
   - parameter textField: textField
   - parameter range:     range
   - parameter string:    string
   - parameter isMobile:  true 手机号 false 银行卡 默认 true
   - parameter maxLegth:  输入长度限制默认 11 位
   
   - returns: Bool
   */
  func insertBlankSpace(textField: UITextField, range: NSRange, string: String, isMobile: Bool = true, maxLegth: Int = 11) -> Bool {
    
    // 插入空格
    func praseMobileText(tampArray: [String], textField: UITextField) {
      var tamp = tampArray.filter { c in
        return c != " "
      }
      
      if tamp.count >= 3 {
        tamp.insert(" ", atIndex: 3)
      }
      
      if tamp.count >= 9 {
        tamp.insert(" ", atIndex: 8)
      }

      
      textField.text = tamp.reduce("", combine: { (str, c) -> String in
        return str + "\(c)"
      })
    }
    
    func praseBankCardText(tampArray: [String], textField: UITextField) {
      var tamp = tampArray.filter { c in
        return c != " "
      }
      
      let count = Int(tamp.count / 4)
      for i in 0...count {
        let insertInex = i * 4
        if tamp.count >= insertInex + i{
          if insertInex == 4 {
            tamp.insert(" ", atIndex: insertInex)
          } else if insertInex > 4{
            tamp.insert(" ", atIndex: insertInex + i - 1)
          }
        }
      }
      
      textField.text = tamp.reduce("", combine: { (str, c) -> String in
        return str + "\(c)"
      })
    }
    
    // 删除操作0
    guard string != "" else {
      var tampArray = textField.text!.characters.map({ (c) -> String in
        "\(c)"
      })
      tampArray.removeAtIndex(range.location)
      
      if isMobile {
        praseMobileText(tampArray, textField: textField)
      } else {
        praseBankCardText(tampArray, textField: textField)
      }
      
      let targerPosition = range.location
//      debugPrint("textField.text.count + \(textField.text?.characters.count)")
//      debugPrint("targetPosition + \(targerPosition)")
      
      // 当删除到空格位置的时候，是无法删除的，因为的上面的算法会自动补全空格，因此 targetposition的位置会在 textfield 的长度多一个位，光标在往前多移动一位
      if targerPosition - textField.text!.characters.count == 1 {
        let position = textField.positionFromPosition(textField.beginningOfDocument, offset: targerPosition - 1)
        let range = textField.textRangeFromPosition(position!, toPosition: position!)
        textField.selectedTextRange = range
        
        return false
      }
      
      let position = textField.positionFromPosition(textField.beginningOfDocument, offset: targerPosition)
      let range = textField.textRangeFromPosition(position!, toPosition: position!)
      textField.selectedTextRange = range
      
      return false
    }
    
    
    // 插入操作
    if string.characters.count > 0 {
      
      let textArray = textField.text?.characters.filter({ (c) -> Bool in
        return c != " "
      })
      
      // 输入长度限制
      guard textArray?.count < maxLegth else {
        return false
      }
      
      textField.insertText(string)
      var targerPosition = range.location + string.characters.count
      
      let tampArray = textField.text!.characters.map({ (c) -> String in
        "\(c)"
      })
      
      
      
      if isMobile {
        praseMobileText(tampArray, textField: textField)
      } else {
        praseBankCardText(tampArray, textField: textField)
      }
      
      // text的长度 比 targetPosition 大一 说明，插入了一个空格，targetPosition 加一
      // 即光标后移一位
      
      // 电话号码
      if (textField.text?.characters.count)! - targerPosition == 1 && (targerPosition == 4 || targerPosition == 9) && isMobile{
        targerPosition = targerPosition + 1
      }
      
      // 银行卡
      if (textField.text?.characters.count)! - targerPosition == 1 && (targerPosition%5 == 0) {
        targerPosition = targerPosition + 1
      }
      
      let position = textField.positionFromPosition(textField.beginningOfDocument, offset: targerPosition)
      let range = textField.textRangeFromPosition(position!, toPosition: position!)
      textField.selectedTextRange = range
      
      return false
    }
    
    return true
  }

}

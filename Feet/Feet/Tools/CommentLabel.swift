//
//  CommentLabel.swift
//  SwiftCocoa
//
//  Created by 王振宇 on 8/3/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

protocol CommentDelegate: class{
  func commentNameselected()
  func commentOtherNameSelected()
  func commentContentSelected()
}

class CommentLabel: UILabel {
  var name: String! = "UOUO"
  var otherName: String! = "HUHU"
  var middleName: String! = " 回复 "
  var comment: String! = "阿萨德剪阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发发"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.numberOfLines = 0
    self.font = UIFont.systemFontOfSize(14)
    setMutableString()
    addTapGestrue()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func addTapGestrue() {
    self.userInteractionEnabled = true
    let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
    self.addGestureRecognizer(tap)
  }
  
  func setMutableString() {
    let mString = NSMutableAttributedString.init(string: "\(name) 回复 \(otherName)：\(comment)")
    mString.addAttribute(NSForegroundColorAttributeName, value: GreenFontColor, range: NSMakeRange(0,name.characters.count))
    
    let nameMiddleCount = name.characters.count + middleName.characters.count
    mString.addAttribute(NSForegroundColorAttributeName, value: GreenFontColor, range: NSMakeRange(nameMiddleCount,otherName.characters.count))
  
    self.attributedText = mString
  }
  
  func nameRect() -> CGRect {
    return rectWithString(name)
  }
  
  func otherNameRect() -> CGRect {
    let nameRect = rectWithString("\(name)\(middleName)")
    let otherNameRect = rectWithString(otherName)
    let rect = CGRect(x: nameRect.origin.x + nameRect.size.width, y: nameRect.origin.y, width: otherNameRect.size.width, height: otherNameRect.size.height)
    return rect
  }
  
  func rectWithString(string: String) -> CGRect {
    let l = UILabel()
    l.text = string
    l.sizeToFit()
    return l.frame
  }
  
  func tapAction(tap: UITapGestureRecognizer) {
    let point = tap.locationInView(self)
    
    if nameRect().contains(point) {
      debugPrint("haha中了")
    } else if otherNameRect().contains(point) {
      debugPrint("中了个蛋")
    } else {
      debugPrint("中了个球")
    }
  }
  
  func refresh(name:String, otherName: String = "", comment: String) {
    self.name = name
    self.otherName = otherName
    self.comment = comment
  }
}

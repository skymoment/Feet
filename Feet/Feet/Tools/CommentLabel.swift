//
//  CommentLabel.swift
//  SwiftCocoa
//
//  Created by 王振宇 on 8/3/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

protocol CommentDelegate: class{
  func commentNameselected(_ name: CommentInfo, y: Int)
  func commentOtherNameSelected(_ otherName: CommentInfo, y: Int)
  func commentContentSelected(_ name: CommentInfo, y: Int)
}

class CommentLabel: UILabel {
  
  weak var delegate: CommentDelegate?
  
  var model: CommentInfo!
  var name: String = "UOUO"
  var otherName: String = "HUHU"
  var middleName: String = " 回复 "
  var comment: String = "阿萨德剪阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发阿萨德剪发发"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.numberOfLines = 0
    self.font = UIFont.systemFont(ofSize: 14)
    setMutableString()
    addTapGestrue()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - LoadData
  func loadData(_ model: CommentInfo) {
    self.model = model
    name = model.nickname
    otherName = model.replyUserName
    comment = model.content
    setMutableString()
  }
  
  func addTapGestrue() {
    self.isUserInteractionEnabled = true
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
  
  func rectWithString(_ string: String) -> CGRect {
    let l = UILabel()
    l.text = string
    l.sizeToFit()
    return l.frame
  }
  
  func tapAction(_ tap: UITapGestureRecognizer) {
    let point = tap.location(in: self)
    let rect = self.superview!.superview!.convert(self.superview!.frame, to: window?.subviews.last)
    let y = Int(rect.origin.y + rect.size.height)
    debugPrint("y === \(y)")
    if nameRect().contains(point) {
      debugPrint("haha中了 \(name)")
      delegate?.commentNameselected(model,y: y)
    } else if otherNameRect().contains(point) {
      debugPrint("中了个蛋 \(otherName)")
      delegate?.commentOtherNameSelected(model,y: y)
    } else {
      debugPrint("中了个球 \(comment)")
      delegate?.commentContentSelected(model,y: y)
    }
  }
  
  func refresh(_ name:String, otherName: String = "", comment: String) {
    self.name = name
    self.otherName = otherName
    self.comment = comment
  }
}

extension UILabel {
  func attrbuteText(_ text: String, color: UIColor,font: UIFont) {
    if self.text!.contains(text) {
      let range = (self.text! as NSString).range(of: text)
      let attr = NSMutableAttributedString(string: self.text!)
      attr.addAttributes([NSForegroundColorAttributeName: color, NSFontAttributeName: font], range: range)
      self.attributedText = attr
    }
  }
}

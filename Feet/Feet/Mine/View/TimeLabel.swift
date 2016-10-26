//
//  TimeLabel.swift
//  Feet
//
//  Created by 王振宇 on 7/10/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class TimeLabel: UILabel {
  
  func setAttrText(text: String) {
    self.textColor = UIColor.whiteColor()
    let attr = NSMutableAttributedString(string: text)
    
    attr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(30), range: NSMakeRange(0, 2))
    
    attr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12), range: NSMakeRange(2, text.characters.count - 2))
    
    self.attributedText = attr
  }
}

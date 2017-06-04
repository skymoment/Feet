//
//  TimeLabel.swift
//  Feet
//
//  Created by 王振宇 on 7/10/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class TimeLabel: UILabel {
  
  func setAttrText(_ text: String) {
    self.textColor = UIColor.white
    let attr = NSMutableAttributedString(string: text)
    
    attr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 30), range: NSMakeRange(0, 2))
    
    attr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(2, text.characters.count - 2))
    
    self.attributedText = attr
  }
}

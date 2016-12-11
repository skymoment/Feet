//
//  CommentCell.swift
//  Feet
//
//  Created by 王振宇 on 8/26/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit
import SnapKit
class CommentCell: UITableViewCell {
  var model: CommentInfo!
  var commentLabel: CommentLabel!
  
  class func identifier() -> String {
    return "CommentCell"
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = UIColor.clearColor()
    self.selectionStyle = .None
    setViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    setViews()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  // SetViews
  func setViews() {
    let c = CommentLabel()
    let v = UIView()
    v.backgroundColor = UIColor.whiteColor()
    contentView.addSubview(v)
    v.snp_makeConstraints { (make) in
      make.left.equalTo(contentView.snp_left).offset(15)
      make.right.equalTo(contentView.snp_right).offset(-15)
      make.top.equalTo(contentView)
      make.bottom.equalTo(contentView.snp_bottom)
    }
    
    v.addSubview(c)
    c.snp_makeConstraints { (make) in
      make.left.equalTo(8)
      make.right.equalTo(-8)
      make.bottom.equalTo(v.snp_bottom).offset(-5)
      make.top.equalTo(v.snp_top).offset(5)
    }
    self.commentLabel = c
  }
 
  func refresh(model: CommentInfo) {
    self.model = model
    
  }
}



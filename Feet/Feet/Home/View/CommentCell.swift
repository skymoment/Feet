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
    self.backgroundColor = UIColor.clear
    self.selectionStyle = .none
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
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  // SetViews
  func setViews() {
    let c = CommentLabel()
    let v = UIView()
    v.backgroundColor = UIColor.white
    contentView.addSubview(v)
    v.snp.makeConstraints { (make) in
      make.left.equalTo(contentView.snp.left).offset(15)
      make.right.equalTo(contentView.snp.right).offset(-15)
      make.top.equalTo(contentView)
      make.bottom.equalTo(contentView.snp.bottom)
    }
    
    v.addSubview(c)
    c.snp.makeConstraints { (make) in
      make.left.equalTo(8)
      make.right.equalTo(-8)
      make.bottom.equalTo(v.snp.bottom).offset(-5)
      make.top.equalTo(v.snp.top).offset(5)
    }
    self.commentLabel = c
  }
 
  func refresh(_ model: CommentInfo) {
    commentLabel.loadData(model)
  }
}



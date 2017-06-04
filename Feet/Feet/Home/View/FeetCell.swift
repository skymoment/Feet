//
//  FeetCell.swift
//  Feet
//
//  Created by 王振宇 on 5/29/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class FeetCell: UITableViewCell {
  
  @IBOutlet weak var backView: UIView!
  @IBOutlet weak var contentLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var lookCountLabel: UILabel!
  @IBOutlet weak var likeCountLabel: UILabel!
  @IBOutlet weak var mainImage: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    self.backgroundColor = UIColor.clear
    self.selectionStyle = .none
    setBackView()
  }
  
  
  // setViews
  func setImageView(_ imageView: UIImageView) {
    imageView.layer.borderWidth = 0
    imageView.layer.borderColor = UIColor.black.cgColor
    imageView.layer.shadowColor = UIColor.black.cgColor //shadowColor阴影颜色
    imageView.layer.shadowOffset = CGSize(width: 2,height: 2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    imageView.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    imageView.layer.shadowRadius = 2;
  }
  
  func setBackView() {
    backView.layer.cornerRadius = 6
    backView.layer.masksToBounds = true
  }
  
  func refresh(_ model: FeetModel) {
    contentLabel.text = model.content
    var city = ""
    if model.city.contains("=") {
      city = model.city.components(separatedBy: "=")[0]
    } else {
      city = model.city
    }
    cityLabel.text = city
    lookCountLabel.text = String(model.lookCount)
    likeCountLabel.text = String(model.likeCount)
    if model.pics.count > 0 {
      let url = URL(string: model.pics[0] + subString)
      mainImage.sd_setImage(with: url)
    }
  }
}

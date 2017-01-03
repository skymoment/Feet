//
//  MineCell.swift
//  Feet
//
//  Created by 王振宇 on 7/10/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class MineCell: UITableViewCell {
  
  weak var timeLabel: TimeLabel!
  weak var contentLabel: UILabel!
  weak var locationLabel: UILabel!
  weak var moodImageView: UIImageView!
  weak var photoImageView: UIImageView!
  weak var countLabel: UILabel!
  
  var vline: CGFloat = 0
  
  convenience init(vLine: CGFloat, style: UITableViewCellStyle, reuseIdentifier: String?) {
    self.init(style: style, reuseIdentifier: reuseIdentifier)
    self.vline = vLine
    setViews()

  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = .None
    self.backgroundColor = UIColor.clearColor()
    
//    setViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func drawRect(rect: CGRect) {
    //获取画笔上下文
    let context:CGContextRef = UIGraphicsGetCurrentContext()!
    //设置画笔的颜色
    CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
    //抗锯齿设置
    CGContextSetAllowsAntialiasing(context, true)
    
    //画直线
    CGContextSetLineWidth(context, 2) //设置画笔的宽度
    CGContextMoveToPoint(context, vline, 0)
    CGContextAddLineToPoint(context, vline, rect.height)
    CGContextStrokePath(context)  //关闭路径
    
    //画圆
    UIColor.whiteColor().set()
    CGContextAddEllipseInRect(context, CGRectMake(107 - 15, 22, 30, 30))
    CGContextFillPath(context)
    
    
    CGContextStrokePath(context)  //关闭路径
  }
  
  class func identifier() -> String{
    return "mineCell"
  }
  
  
  func setViews() {
    
    moodImageView = {
      let m = UIImageView(image: UIImage(named: "mood_h"))
      self.addSubview(m)
      m.snp_makeConstraints(closure: { (make) in
        make.top.equalTo(22 + 2)
        make.left.equalTo(106 - 12)
        make.width.height.equalTo(26)
      })
      return m
    }()
    
    timeLabel = {
      let t = TimeLabel()
      t.setAttrText("0707月")
      self.addSubview(t)
      t.snp_makeConstraints(closure: { (make) in
        make.centerY.equalTo(moodImageView)
        make.left.equalTo(10)
      })
      return t
    }()
    
    locationLabel = {
      let l = UILabel()
      l.text = "上海"
      l.font = UIFont.systemFontOfSize(12)
      l.textColor = UIColor.whiteColor()
      self.addSubview(l)
      l.snp_makeConstraints(closure: { (make) in
        make.top.equalTo(timeLabel.snp_bottom)
        make.left.equalTo(timeLabel.snp_left)
      })
      return l
    }()
    
    contentLabel = {
      let c = UILabel()
      c.text = "这个是世界很无奈"
      c.font = UIFont.systemFontOfSize(14)
      c.textColor = UIColor.whiteColor()
      self.addSubview(c)
      c.snp_makeConstraints(closure: { (make) in
        make.left.equalTo(106 + 15)
        make.top.equalTo(moodImageView.snp_bottom).offset(2)
        make.right.equalTo(self.snp_right).offset(-15)
      })
      return c
    }()
    
    photoImageView = {
      let p = UIImageView(image: UIImage(named: "image1"))
      self.addSubview(p)
      p.snp_makeConstraints(closure: { (make) in
        make.left.equalTo(contentLabel.snp_left)
        make.top.equalTo(contentLabel.snp_bottom).offset(10)
        make.width.height.equalTo(60)
      })
      return p
    }()
    
    countLabel = {
      let c = UILabel()
      c.textColor = UIColor.whiteColor()
      c.text = "共5张"
      c.font = UIFont.systemFontOfSize(12)
      self.addSubview(c)
      c.snp_makeConstraints(closure: { (make) in
        make.left.equalTo(photoImageView.snp_right).offset(10)
        make.bottom.equalTo(photoImageView.snp_bottom)
      })
      return c
    }()
  }
  
  func refresh(model: FeetModel) {
    countLabel.text = "共\(model.pics.count)张"
    contentLabel.text = model.content
    
    if let url = NSURL(string: model.pics[0]) {
      photoImageView.sd_setImageWithURL(url)
    }
//    photoImageView.image = UIImag
  }
}

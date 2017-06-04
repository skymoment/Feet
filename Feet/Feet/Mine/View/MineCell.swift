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
    self.selectionStyle = .none
    self.backgroundColor = UIColor.clear
    
//    setViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func draw(_ rect: CGRect) {
    //获取画笔上下文
    let context:CGContext = UIGraphicsGetCurrentContext()!
    //设置画笔的颜色
    context.setStrokeColor(UIColor.white.cgColor)
    //抗锯齿设置
    context.setAllowsAntialiasing(true)
    
    //画直线
    context.setLineWidth(2) //设置画笔的宽度
    context.move(to: CGPoint(x: vline, y: 0))
    context.addLine(to: CGPoint(x: vline, y: rect.height))
    context.strokePath()  //关闭路径
    
    //画圆
    UIColor.white.set()
    context.addEllipse(in: CGRect(x: 107 - 15, y: 22, width: 30, height: 30))
    context.fillPath()
    
    
    context.strokePath()  //关闭路径
  }
  
  class func identifier() -> String{
    return "mineCell"
  }
  
  
  func setViews() {
    
    moodImageView = {
      let m = UIImageView(image: UIImage(named: "mood_h"))
      self.addSubview(m)
      m.snp.makeConstraints({ (make) in
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
      t.snp.makeConstraints({ (make) in
        make.centerY.equalTo(moodImageView)
        make.left.equalTo(10)
      })
      return t
    }()
    
    locationLabel = {
      let l = UILabel()
      l.text = "上海"
      l.font = UIFont.systemFont(ofSize: 12)
      l.textColor = UIColor.white
      self.addSubview(l)
      l.snp.makeConstraints({ (make) in
        make.top.equalTo(timeLabel.snp.bottom)
        make.left.equalTo(timeLabel.snp.left)
      })
      return l
    }()
    
    contentLabel = {
      let c = UILabel()
      c.text = "这个是世界很无奈"
      c.font = UIFont.systemFont(ofSize: 14)
      c.textColor = UIColor.white
      self.addSubview(c)
      c.snp.makeConstraints({ (make) in
        make.left.equalTo(106 + 15)
        make.top.equalTo(moodImageView.snp.bottom).offset(2)
        make.right.equalTo(self.snp.right).offset(-15)
      })
      return c
    }()
    
    photoImageView = {
      let p = UIImageView(image: UIImage(named: "image1"))
      p.layer.cornerRadius = 3
      p.layer.masksToBounds = true
      self.addSubview(p)
      p.snp.makeConstraints({ (make) in
        make.left.equalTo(contentLabel.snp.left)
        make.top.equalTo(contentLabel.snp.bottom).offset(10)
        make.width.height.equalTo(60)
      })
      return p
    }()
    
    countLabel = {
      let c = UILabel()
      c.textColor = UIColor.white
      c.text = "共5张"
      c.font = UIFont.systemFont(ofSize: 12)
      self.addSubview(c)
      c.snp.makeConstraints({ (make) in
        make.left.equalTo(photoImageView.snp.right).offset(10)
        make.bottom.equalTo(photoImageView.snp.bottom)
      })
      return c
    }()
  }
  
  func refresh(_ model: FeetModel) {
    countLabel.text = "共\(model.pics.count)张"
    contentLabel.text = model.content
    timeLabel.setAttrText(parseTime(model.time))
    locationLabel.text = model.city.components(separatedBy: "=")[0]
    
    if let url = URL(string: model.pics[0]) {
      photoImageView.sd_setImage(with: url)
    }
  }
  
  func parseTime(_ str: String) -> String {
    let time1 = str.components(separatedBy: " ")
    let time2 = time1[0].components(separatedBy: "-")
    let time3 = time2[1] + time2[2] + "月"
    return time3
  }
}

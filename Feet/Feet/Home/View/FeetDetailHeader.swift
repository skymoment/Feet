//
//  FeetDetailHeader.swift
//  Feet
//
//  Created by 王振宇 on 8/17/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class FeetDetailHeader: UIView {
  
  var contentView: UIView!
  var detailScroller: DetailScorllerView!
  var images = [String]()
  var avatarView: UIImageView!
  var nameLable: UILabel!
  var timeAndCity: UILabel!
  var contentLabel: UILabel!
  
  var watchView: UIImageView!
  var watchLabel: UILabel!
  var likeView: UIImageView!
  var likeLabel: UILabel!
  var linelabel: UILabel!
  
  var model: FeetDetailModel!
  
  // MARK: - LifeCycle
  convenience init(model: FeetDetailModel) {
    self.init(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 10))
    self.model = model
    setViews()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - SetViews
  func setViews() {
    contentView = {
      let c = UIView()
      c.backgroundColor = UIColor.white
      c.layer.cornerRadius = 8
      c.layer.masksToBounds = true
      addSubview(c)
      return c
    }()
    
    
    if model.feetInfo.pics.count > 0 {
      images.append(model.feetInfo.pics[0])
    }
    let s = DetailScorllerView(images: images)
    contentView.addSubview(s)
    detailScroller = s
    
    avatarView = {
      let a = UIImageView(image: UIImage(named: "d_header"))
      let url = URL(string: model.feetInfo.image)
      if let url = url {
        a.sd_setImage(with: url)
      }
      a.cornerRadiusImageView(12)
      contentView.addSubview(a)
      a.snp.makeConstraints { (make) in
        make.top.equalTo(detailScroller.snp.bottom).offset(15)
        make.left.equalTo(contentView.snp.left).offset(12)
        make.width.height.equalTo(24)
      }
      return a
    }()
    
    nameLable = {
      let n = UILabel()
      n.text = model.feetInfo.nickname
      n.textColor = UIColor(hexString: "#11d211")
      n.font = UIFont.systemFont(ofSize: 15)
      contentView.addSubview(n)
      n.snp.makeConstraints { (make) in
        make.left.equalTo(avatarView.snp.right).offset(6)
        make.centerY.equalTo(avatarView)
      }
      return n
    }()
    
    timeAndCity = {
      let l = UILabel()
      l.text = model.feetInfo.time
      l.font = UIFont.systemFont(ofSize: 12)
      l.textColor = UIColor(hexString: "#646464")
      contentView.addSubview(l)
      l.snp.makeConstraints { (make) in
        make.centerY.equalTo(nameLable)
        make.right.equalTo(contentView.snp.right).offset(-12)
      }
      return l
    }()
    
    contentLabel = {
      let c = UILabel()
      c.font = UIFont.systemFont(ofSize: 15)
      c.textColor = MianFontColor
      c.numberOfLines = 0
      c.text = model.feetInfo.content
      contentView.addSubview(c)
      c.snp.makeConstraints { (make) in
        make.top.equalTo(avatarView.snp.bottom).offset(6)
        make.left.equalTo(avatarView.snp.left)
        make.right.equalTo(timeAndCity.snp.right)
      }
      return c
    }()
    
    watchView = {
      let i = UIImageView(image: UIImage(named: "looks"))
      contentView.addSubview(i)
      i.snp.makeConstraints { (make) in
        make.top.equalTo(contentLabel.snp.bottom).offset(15)
        make.left.equalTo(avatarView.snp.left)
        make.width.equalTo(18)
        make.height.equalTo(18)
      }
      return i
    }()
    
    watchLabel = {
      let l = UILabel()
      l.text = "\(model.feetInfo.lookCount)"
      l.textColor = MianFontColor
      l.font = UIFont.systemFont(ofSize: 15)
      contentView.addSubview(l)
      l.snp.makeConstraints { (make) in
        make.centerY.equalTo(watchView)
        make.left.equalTo(watchView.snp.right).offset(4)
      }
      return l
    }()
    
    likeLabel = {
      let l = UILabel()
      l.text = "\(model.feetInfo.likeCount)"
      l.textColor = MianFontColor
      l.font = UIFont.systemFont(ofSize: 15)
      contentView.addSubview(l)
      l.snp.makeConstraints { (make) in
        make.centerY.equalTo(watchView)
        make.right.equalTo(timeAndCity.snp.right)
      }
      return l
    }()
    
    likeView = {
      let i = UIImageView()
      if model.feetInfo.selflike != 0 {
        i.image = UIImage(named: "loved")
      } else {
        i.image = UIImage(named: "loves")
      }
      contentView.addSubview(i)
      i.snp.makeConstraints { (make) in
        make.right.equalTo(likeLabel.snp.left).offset(-4)
        make.centerY.equalTo(watchView)
        make.width.equalTo(18)
        make.height.equalTo(18)
      }
      return i
    }()
    
    let likeControl = UIControl()
    likeControl.addTarget(self, action: #selector(likeAction), for: .touchDown)
    contentView.addSubview(likeControl)
    likeControl.snp.makeConstraints { (make) in
      make.right.equalTo(timeAndCity.snp.right).offset(4)
      make.centerY.equalTo(watchView)
      make.width.equalTo(80)
      make.height.equalTo(38)
    }
    
    linelabel = {
      let l = UILabel()
      l.backgroundColor = LineColor
      contentView.addSubview(l)
      l.snp.makeConstraints { (make) in
        make.top.equalTo(likeView.snp.bottom).offset(10)
        make.left.equalTo(contentView.snp.left)
        make.right.equalTo(contentView.snp.right)
        make.height.equalTo(0.5)
      }
      return l
    }()
    
    contentView.snp.makeConstraints { (make) in
      make.left.equalTo(15)
      make.right.equalTo(detailScroller.snp.right)
      make.top.equalTo(0)
      make.bottom.equalTo(linelabel.snp.bottom).offset(5)
    }
    contentView.layoutIfNeeded()
    self.frame = CGRect(x: 15, y: 0, width: KScreenWidth-30, height: contentView.height)
    
    if model.commentInfo.count > 0 {
      let whiteView = UIView(frame: CGRect(x: self.x + 0.5,y: self.y+8,width: self.width - 1,height: self.height))
      whiteView.backgroundColor = UIColor.white
      insertSubview(whiteView, belowSubview: contentView)
    } else {
      linelabel.backgroundColor = UIColor.clear
    }

  }
  
  
  // MARK: - Actions
  func pushPersonInfo() {
    debugPrint("push to person info")
  }
  
  func likeAction() {
    debugPrint("likeAction")
    HomeNetworkTool.zanFeet(["feetid": "\(model.feetInfo.id)"]) { promiseModel in
      do {
        let _ = try promiseModel.then({model in
          self.likeView.image = UIImage(named: "loved")
        }).resolve()
      } catch where error is MyError{
        debugPrint("\(error)")
      } catch{
        debugPrint("网络错误")
      }
    }
  }
}

//
//  FeetDetailHeader.swift
//  Feet
//
//  Created by 王振宇 on 8/17/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class FeetDetailHeader: UIView {
  
  var images: [String] = ["image1","image2","image3"]
  
  var contentView: UIView!
  var detailScroller: DetailScorllerView!
  
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
      c.backgroundColor = UIColor.whiteColor()
      c.layer.cornerRadius = 8
      c.layer.masksToBounds = true
      addSubview(c)
      return c
    }()
    
    let s = DetailScorllerView(images: images)
    contentView.addSubview(s)
    detailScroller = s
    
    avatarView = {
      let a = UIImageView(image: UIImage(named: "m_default"))
      a.cornerRadiusImageView(12)
      contentView.addSubview(a)
      a.snp_makeConstraints { (make) in
        make.top.equalTo(detailScroller.snp_bottom).offset(15)
        make.left.equalTo(contentView.snp_left).offset(12)
        make.width.height.equalTo(24)
      }
      return a
    }()
    
    nameLable = {
      let n = UILabel()
      n.text = "转交遇到爱"
      n.textColor = UIColor(hexString: "#11d211")
      n.font = UIFont.systemFontOfSize(15)
      contentView.addSubview(n)
      n.snp_makeConstraints { (make) in
        make.left.equalTo(avatarView.snp_right).offset(6)
        make.centerY.equalTo(avatarView)
      }
      return n
    }()
    
    timeAndCity = {
      let l = UILabel()
      l.text = model.feetInfo.time
      l.font = UIFont.systemFontOfSize(12)
      l.textColor = UIColor(hexString: "#646464")
      contentView.addSubview(l)
      l.snp_makeConstraints { (make) in
        make.centerY.equalTo(nameLable)
        make.right.equalTo(contentView.snp_right).offset(-12)
      }
      return l
    }()
    
    contentLabel = {
      let c = UILabel()
      c.font = UIFont.systemFontOfSize(15)
      c.textColor = MianFontColor
      c.numberOfLines = 0
      c.text = model.feetInfo.content
      contentView.addSubview(c)
      c.snp_makeConstraints { (make) in
        make.top.equalTo(avatarView.snp_bottom).offset(6)
        make.left.equalTo(avatarView.snp_left)
        make.right.equalTo(timeAndCity.snp_right)
      }
      return c
    }()
    
    watchView = {
      let i = UIImageView(image: UIImage(named: "looks"))
      contentView.addSubview(i)
      i.snp_makeConstraints { (make) in
        make.top.equalTo(contentLabel.snp_bottom).offset(15)
        make.left.equalTo(avatarView.snp_left)
        make.width.equalTo(18)
        make.height.equalTo(18)
      }
      return i
    }()
    
    watchLabel = {
      let l = UILabel()
      l.text = "\(model.feetInfo.lookCount)"
      l.textColor = MianFontColor
      l.font = UIFont.systemFontOfSize(15)
      contentView.addSubview(l)
      l.snp_makeConstraints { (make) in
        make.centerY.equalTo(watchView)
        make.left.equalTo(watchView.snp_right).offset(4)
      }
      return l
    }()
    
    likeLabel = {
      let l = UILabel()
      l.text = "\(model.feetInfo.likeCount)"
      l.textColor = MianFontColor
      l.font = UIFont.systemFontOfSize(15)
      contentView.addSubview(l)
      l.snp_makeConstraints { (make) in
        make.centerY.equalTo(watchView)
        make.right.equalTo(timeAndCity.snp_right)
      }
      return l
    }()
    
    likeView = {
      let i = UIImageView(image: UIImage(named: "loves"))
      let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(likeAction))
      i.userInteractionEnabled = true
      i.addGestureRecognizer(tapGestrue)
      contentView.addSubview(i)
      i.snp_makeConstraints { (make) in
        make.right.equalTo(likeLabel.snp_left).offset(-4)
        make.centerY.equalTo(watchView)
        make.width.equalTo(18)
        make.height.equalTo(18)
      }
      return i
    }()
    
    linelabel = {
      let l = UILabel()
      l.backgroundColor = LineColor
      contentView.addSubview(l)
      l.snp_makeConstraints { (make) in
        make.top.equalTo(likeView.snp_bottom).offset(10)
        make.left.equalTo(contentView.snp_left)
        make.right.equalTo(contentView.snp_right)
        make.height.equalTo(0.5)
      }
      return l
    }()
    
    contentView.snp_makeConstraints { (make) in
      make.left.equalTo(15)
      make.right.equalTo(detailScroller.snp_right)
      make.top.equalTo(0)
      make.bottom.equalTo(linelabel.snp_bottom).offset(5)
    }
    contentView.layoutIfNeeded()
    self.frame = CGRect(x: 15, y: 0, width: KScreenWidth-30, height: contentView.height)
    
    if model.commentInfo.count > 0 {
      let whiteView = UIView(frame: CGRect(x: self.x + 0.5,y: self.y+8,width: self.width - 1,height: self.height))
      whiteView.backgroundColor = UIColor.whiteColor()
      insertSubview(whiteView, belowSubview: contentView)
    } else {
      linelabel.backgroundColor = UIColor.clearColor()
    }

  }
  
  
  // MARK: - Actions
  func pushPersonInfo() {
    debugPrint("push to person info")
  }
  
  func likeAction() {
    debugPrint("likeAction")
    HomeNetworkTool.zanFeet(["feetid": "102"]) { promiseModel in
      do {
        let _ = try promiseModel.then({model in
//          self.feetModels = models
//          self.tableView.reloadData()
        }).resolve()
      } catch where error is MyError{
        debugPrint("\(error)")
      } catch{
        debugPrint("网络错误")
      }
    }
  }
}

//
//  PostView.swift
//  Feet
//
//  Created by 王振宇 on 7/9/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit


@objc
protocol PostViewDelegate: class {
  func viewAddImage(isMain: Bool)
  func viewSelectLocation()
  func viewUpdateHeight(height: Int,hx: Int)
  func viewLittleImageViewTapped(imageViewTag: Int)
}

class PostView: UIView {
  
  weak var backView: UIView!
  weak var imageView1: UIImageView!
  weak var addImageView: SmallImageView!
  weak var textView: KMPlaceholderTextView!
  weak var locationImage: UIImageView!
  weak var locationLabel: UILabel!
  weak var moodButton1: UIButton!
  
  weak var delegate: PostViewDelegate!

  let imageTagA = 100   // 小的图片 四张
  let imageWidthHeight = 40 // 小图宽高
  var imageViews = [UIImageView]()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - SetView
  func setViews() {
    
    backView = {
      let v = UIView()
      v.backgroundColor = UIColor.whiteColor()
      v.layer.cornerRadius = 6
      v.layer.masksToBounds = true
      self.addSubview(v)
      return v
    }()
    
    imageView1 = {
      let v = UIImageView(image: UIImage(named: "beauti2"))
      v.tag = 1 + 1000
      v.userInteractionEnabled = true
      let gesture = UITapGestureRecognizer(target: self,action: #selector(addImage))
      v.addGestureRecognizer(gesture)
      backView.addSubview(v)
      v.snp_makeConstraints(closure: { (make) in
        make.top.left.right.equalTo(0)
        make.height.equalTo((KScreenWidth-30)*9/17)
      })
      return v
    }()
    
    addImageView = {
      let v = SmallImageView(frame: CGRectZero)
      v.image = UIImage(named: "image1")
      v.tag = 2
      v.userInteractionEnabled = true
      let gesture = UITapGestureRecognizer(target: self,action: #selector(addImage))
      v.addGestureRecognizer(gesture)
      imageView1.addSubview(v)
      v.snp_makeConstraints(closure: { (make) in
        make.left.equalTo(8).priorityMedium()
        make.bottom.equalTo(imageView1.snp_bottom).offset(-6)
        make.height.width.equalTo(40)
      })
      v.hidden = true
      return v
    }()
    
    textView = {
      let t = KMPlaceholderTextView()
      t.text = "总有一天，我会回来的！"
      t.font = UIFont.systemFontOfSize(14)
      t.scrollEnabled = false
      t.delegate = self
      backView.addSubview(t)
      t.snp_makeConstraints(closure: { (make) in
        make.top.equalTo(imageView1.snp_bottom).offset(8)
        make.left.equalTo(imageView1.snp_left).offset(8)
        make.right.equalTo(imageView1.snp_right).offset(-8)
        make.height.equalTo(35).priorityMedium()
      })
    
      return t
    }()
    
    locationImage = {
      let l = UIImageView(image: UIImage(named: "p_location"))
      backView.addSubview(l)
      l.snp_makeConstraints(closure: { (make) in
        make.top.equalTo(textView.snp_bottom).offset(8)
        make.left.equalTo(textView.snp_left)
        make.width.height.equalTo(16)
      })
      return l
    }()
    
    locationLabel = {
      let l = UILabel()
      l.userInteractionEnabled = true
      l.text = "抱歉定位失败，点击选取您当前的位置"
      l.font = UIFont.systemFontOfSize(12)
      l.textColor = mainTextColor
      let gesture = UITapGestureRecognizer(target: self,action: #selector(selectLocation))
      l.addGestureRecognizer(gesture)
      backView.addSubview(l)
      l.snp_makeConstraints(closure: { (make) in
        make.centerY.equalTo(locationImage)
        make.left.equalTo(locationImage.snp_right).offset(4)
      })
      return l
    }()
    
    moodButton1 = {
      let btn = UIButton(type: .Custom)
      btn.backgroundColor = UIColor.greenColor()
      btn.addTarget(self, action: #selector(moodSelected), forControlEvents: .TouchUpInside)
      backView.addSubview(btn)
      btn.snp_makeConstraints(closure: { (make) in
        make.top.equalTo(locationLabel.snp_bottom).offset(15)
        make.centerX.equalTo(self)
        make.height.width.equalTo(16)
      })
      return btn
    }()
    
    backView.snp_makeConstraints(closure: { (make) in
      make.top.equalTo(0)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(114 + (KScreenWidth - 30)*9/17).priorityMedium()
    })
  }
  
  // MARK: - Action
  func moodSelected(button: UIButton){
    debugPrint("选择心情")
  }
  
  func addImage(gestrue: UITapGestureRecognizer) {
    if gestrue.view!.tag == 1001 {
      delegate.viewAddImage(true)
    } else {
      delegate.viewAddImage(false)
    }
  }
  
  func selectLocation() {
    delegate.viewSelectLocation()
  }
  
  func littleImageViewTapped(gestrue: UITapGestureRecognizer) {
    let imageViewTag = gestrue.view!.tag % 100
    delegate.viewLittleImageViewTapped(imageViewTag)
  }
  
  // 添加 四张图片在的主图上面
  func addImageViews(images: [UIImage]) {
    imageViews.removeAll()
    for (index,value) in images.enumerate() {
      let imageView = UIImageView(image: value)
      imageView.tag = imageTagA + index
      imageView1.addSubview(imageView)
      let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(littleImageViewTapped))
      imageView.addGestureRecognizer(tapGestrue)
      let left = index * imageWidthHeight + 8 + index * 8
      imageView.snp_makeConstraints(closure: { (make) in
          make.left.equalTo(left)
          make.bottom.equalTo(imageView1.snp_bottom).offset(-6)
          make.height.width.equalTo(40)
      })
    }
    
    let addImageViewLeft = 8 + (images.count * 8) + images.count * imageWidthHeight
    addImageView.snp_updateConstraints(closure: { (make) in
      make.left.equalTo(addImageViewLeft)
    })
  }
}

extension PostView:UITextViewDelegate {
  func textViewDidChange(textView: UITextView) {
    //计算 text view 的高度
    
    let attrs = [NSFontAttributeName: UIFont.systemFontOfSize(14)]
    let rect = textView.text.boundingRectWithSize(CGSize(width: KScreenWidth - 60, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attrs, context: nil)
    
    let hx = Int(rect.height/14)
    let height = 290 - 176 + (KScreenWidth - 30)*9/17
    if hx >= 1 {
      textView.snp_updateConstraints { (make) -> Void in
        let height = 35+(17*(hx - 1))
        make.height.equalTo(height)
        self.delegate.viewUpdateHeight(height,hx: hx)
      }
      
      backView.snp_updateConstraints(closure: { (make) in
        let h = Int(height)+(17*(hx - 1))
        make.height.equalTo(h)
      })
    }
    
    UIView.animateWithDuration(0.5) { 
      self.layoutIfNeeded()
    }
  }
}

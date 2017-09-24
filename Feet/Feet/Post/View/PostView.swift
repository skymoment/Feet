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
  func viewAddImage(_ isMain: Bool)
  func viewSelectLocation()
  func viewUpdateHeight(_ height: Int,hx: Int)
  func viewLittleImageViewTapped(_ imageViewTag: Int)
}

class PostView: UIView {
  
  weak var backView: UIView!
  weak var imageView1: UIImageView!
  weak var cameraView: UIView!
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
      v.backgroundColor = UIColor.white
      v.layer.cornerRadius = 6
      v.layer.masksToBounds = true
      self.addSubview(v)
      return v
    }()
    
    cameraView = {
      let v = UIView()
      v.isUserInteractionEnabled = true
      let gesture = UITapGestureRecognizer(target: self,action: #selector(addImage))
      v.addGestureRecognizer(gesture)
      backView.addSubview(v)
      v.snp.makeConstraints { (make) in
        make.top.left.right.equalTo(0)
        make.height.equalTo((KScreenWidth-30)*9/17)
      }
      return v
    }()
    
    let imageView = UIImageView(image: UIImage(named: "camera"))
    cameraView.addSubview(imageView)
    imageView.snp.makeConstraints({ (make) in
      make.center.equalTo(cameraView)
    })
    
    
    imageView1 = {
      let v = UIImageView()
      v.tag = 1 + 1000
      v.isUserInteractionEnabled = true
      let gesture = UITapGestureRecognizer(target: self,action: #selector(addImage))
      v.addGestureRecognizer(gesture)
      backView.addSubview(v)
      v.snp.makeConstraints({ (make) in
        make.top.left.right.equalTo(0)
        make.height.equalTo((KScreenWidth-30)*9/17)
      })
      v.isHidden = true
      return v
    }()
    
    addImageView = {
      let v = SmallImageView(frame: CGRect.zero)
      v.image = UIImage(named: "image1")
      v.tag = 2
      v.isUserInteractionEnabled = true
//      let gesture = UITapGestureRecognizer(target: self,action: #selector(addImage))
//      v.addGestureRecognizer(gesture)
      imageView1.addSubview(v)
      v.snp.makeConstraints({ (make) in
        make.left.equalTo(8).priorityMedium()
        make.bottom.equalTo(imageView1.snp.bottom).offset(-6)
        make.height.width.equalTo(40)
      })
      v.isHidden = true
      return v
    }()
    
    textView = {
      let t = KMPlaceholderTextView()
      t.placeholder = "生活不应只有眼前的苟且，还有诗和远方"
      t.font = UIFont.systemFont(ofSize: 14)
      t.isScrollEnabled = false
      t.delegate = self
      backView.addSubview(t)
      t.snp.makeConstraints({ (make) in
        make.top.equalTo(imageView1.snp.bottom).offset(8)
        make.left.equalTo(imageView1.snp.left).offset(8)
        make.right.equalTo(imageView1.snp.right).offset(-8)
        make.height.equalTo(35).priority(700)
        make.height.equalTo(35)
      })
    
      return t
    }()
    
    locationImage = {
      let l = UIImageView(image: UIImage(named: "p_location"))
      backView.addSubview(l)
      l.snp.makeConstraints({ (make) in
        make.top.equalTo(textView.snp.bottom).offset(8)
        make.left.equalTo(textView.snp.left)
        make.width.height.equalTo(16)
      })
      return l
    }()
    
    locationLabel = {
      let l = UILabel()
      l.isUserInteractionEnabled = true
      l.text = "正在定位..."
      l.font = UIFont.systemFont(ofSize: 12)
      l.textColor = mainTextColor
      let gesture = UITapGestureRecognizer(target: self,action: #selector(selectLocation))
      l.addGestureRecognizer(gesture)
      backView.addSubview(l)
      l.snp.makeConstraints({ (make) in
        make.centerY.equalTo(locationImage)
        make.left.equalTo(locationImage.snp.right).offset(4)
      })
      return l
    }()
    
    moodButton1 = {
      let btn = UIButton(type: .custom)
      btn.backgroundColor = UIColor.green
      btn.addTarget(self, action: #selector(moodSelected), for: .touchUpInside)
      backView.addSubview(btn)
      btn.snp.makeConstraints({ (make) in
        make.top.equalTo(locationLabel.snp.bottom).offset(15)
        make.centerX.equalTo(self)
        make.height.width.equalTo(16)
      })
      btn.isHidden = true
      return btn
    }()
    
    backView.snp.makeConstraints({ (make) in
      make.top.equalTo(0)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(98 + (KScreenWidth - 30)*9/17)
      make.height.equalTo(98 + (KScreenWidth - 30)*9/17).priority(700)
    })
  }
  
  // MARK: - Action
  func moodSelected(_ button: UIButton){
    debugPrint("选择心情")
  }
  
  func addImage(_ gestrue: UITapGestureRecognizer) {
    imageView1.isHidden = false
//    if gestrue.view!.tag == 1001 {
    delegate.viewAddImage(true)
//    } else {
//      delegate.viewAddImage(false)
//    }
  }
  
  func selectLocation() {
    delegate.viewSelectLocation()
  }
  
  func littleImageViewTapped(_ gestrue: UITapGestureRecognizer) {
    let imageViewTag = gestrue.view!.tag % 100
    delegate.viewLittleImageViewTapped(imageViewTag)
  }
  
  // 添加 四张图片在的主图上面
  func addImageViews(_ images: [UIImage]) {
    imageViews.removeAll()
    for (index,value) in images.enumerated() {
      let imageView = UIImageView(image: value)
      imageView.tag = imageTagA + index
      imageView1.addSubview(imageView)
      let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(littleImageViewTapped))
      imageView.addGestureRecognizer(tapGestrue)
      let left = index * imageWidthHeight + 8 + index * 8
      imageView.snp.makeConstraints({ (make) in
          make.left.equalTo(left)
          make.bottom.equalTo(imageView1.snp.bottom).offset(-6)
          make.height.width.equalTo(40)
      })
    }
    
    let addImageViewLeft = 8 + (images.count * 8) + images.count * imageWidthHeight
    addImageView.snp.updateConstraints({ (make) in
      make.left.equalTo(addImageViewLeft)
    })
  }
}

extension PostView:UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    //计算 text view 的高度
    
    let attrs = [NSFontAttributeName: UIFont.systemFont(ofSize: 14)]
    let rect = textView.text.boundingRect(with: CGSize(width: KScreenWidth - 60, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrs, context: nil)
    
    let hx = Int(rect.height/14)
    let height = 290 - 176 + (KScreenWidth - 30)*9/17 - 16
    if hx >= 1 {
      textView.snp.updateConstraints { (make) -> Void in
        let height = 35+(17*(hx - 1))
        make.height.equalTo(height)
        self.delegate.viewUpdateHeight(height,hx: hx)
      }
      
      backView.snp.updateConstraints({ (make) in
        let h = Int(height)+(17*(hx - 1))
        make.height.equalTo(h)
      })
    }
    
    UIView.animate(withDuration: 0.5, animations: { 
      self.layoutIfNeeded()
    }) 
  }
}

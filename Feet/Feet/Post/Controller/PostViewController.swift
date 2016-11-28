//
//  PostViewController.swift
//  Feet
//
//  Created by 王振宇 on 7/7/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
  
  weak var scrollerView: UIScrollView!
  weak var cancelBtn: UIButton!
  weak var postBtn: UIButton!
  
  var imagePicker: ImagePicker!
  var postView: PostView!
  
  let location = LoactionTool.shareInstance
  var isMain: Bool = true
  var images: [UIImage] = []
  var imagesPaths: [String] = []
  var locationXY: String = "上海市"
  
  var postViewUpdateHeight = 35
  var scorllerOffsetY:CGFloat = 0
  
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.whiteColor()
    setViews()
    gainQiNiuToken()
    
    if location.isEnableLocation() {
      location.delegate = self
    } else {
      // WARNING: to do
      postView.locationLabel.text = "定位失败咯，点击可以输入你的位置吧"
      debugPrint("定位失败")
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(dismissKeyBoard), name: UIKeyboardWillHideNotification, object: nil)
    (tabBarController as! TabBarController).removeGestrue()
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)

  }
  
  // MARK: - SetViews
  func setViews() {
    view.addSubview(BackView())
    
    view.userInteractionEnabled = true
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
    view.addGestureRecognizer(tapGesture)
    
    cancelBtn = {
      let btn = UIButton(type: .System)
      btn.setImage(UIImage(named: "l_close"), forState: .Normal)
      btn.tintColor = UIColor.whiteColor()
      btn.addTarget(self, action: #selector(popAction), forControlEvents: .TouchUpInside)
      view.addSubview(btn)
      btn.snp_makeConstraints(closure: { (make) in
        make.top.equalTo(22)
        make.left.equalTo(15)
        make.width.height.equalTo(28)
      })
      return btn
    }()
    
    postBtn = {
      let btn = UIButton(type: .System)
      btn.setTitle("发布", forState: .Normal)
      btn.tintColor = UIColor.whiteColor()
      btn.titleLabel?.font = UIFont.systemFontOfSize(22)
      btn.addTarget(self, action: #selector(postAction), forControlEvents: .TouchUpInside)
      view.addSubview(btn)
      btn.snp_makeConstraints(closure: { (make) in
        make.centerY.equalTo(cancelBtn)
        make.right.equalTo(-15)
        make.width.equalTo(50)
        make.height.equalTo(40)
      })
      return btn
    }()
    
    scrollerView = {
      let s = UIScrollView()
      s.backgroundColor = UIColor.clearColor()
      s.frame = CGRect(x: 0, y: 64, width: KScreenWidth, height: KScreenHeigth - 64)
      s.delegate = self
      view.addSubview(s)
      return s
    }()
    
    postView = {
      let p = PostView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 290 - 176 + (KScreenWidth - 30)*9/16))
      p.delegate = self
      scrollerView.addSubview(p)
      scrollerView.contentSize = CGSize(width: p.frame.width, height: p.frame.height + 64)
      return p
    }()
    
  }
  
  // MARK: - Methods
  func dismissKeyBoard() {
    view.endEditing(true)
    UIView.animateWithDuration(0.3) { 
      self.scrollerView.contentOffset.y = 0
    }
  }
  
  func popAction() {
    navigationController?.popViewControllerAnimated(true)
  }
  
  func keyboardWillChangeFrame(notification: NSNotification) {
    let rect = notification.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
    var ty:CGFloat = 0
    // 64 tableView的偏移量，第三方建盘与 y为286，原始键盘y为 352相差 66
    ty = postView.frame.origin.y + postView.frame.size.height - rect.origin.y + 64
    scorllerOffsetY = ty
    UIView.animateWithDuration(0.3, animations: {
      self.scrollerView.contentOffset.y = ty
    })
  }
  
  func postAction() {
    debugPrint("正在发布发布")
    
    QiniuTool.upLoadImages(imagesPaths, completion: { (progress, keys) in
      debugPrint("上传进度 \(progress)")
      if progress == 1 {
        self.postToServer(keys)
      }
    }) {
      debugPrint("上传失败")
    }
  }
  
  func gainQiNiuToken() {
    PostNetTool.qiuNiuToken()
  }
  
  
  // 上传 feet 到 自己服务器上
  func postToServer(paths: [String]) {
    
    let newPaths = paths.map { s in
      return QNHeader + s
    }
    
    var imgs = ""
    for (index,path) in newPaths.enumerate() {
      if index == paths.count {
        imgs = imgs + path
      } else {
        imgs = imgs + path + ","
      }
    }
    
    debugPrint(imgs)
    
    let params = [
      "content": postView.textView.text!,
      "city": locationXY,
      "imgs": imgs,
      "mood": "2"
    ]
    
    PostNetTool.post(params) { promiseString in
      do {
        let _ = try promiseString.then({str in
          debugPrint("发布结果 ===== \(str)")
          self.popAction()
        }).resolve()
      } catch where error is MyError{
        debugPrint("\(error)")
      } catch{
        debugPrint("网络错误")
      }
    }
  }
}

// MARK: - PostViewDelegate
extension PostViewController: PostViewDelegate {
  func viewAddImage(isMain: Bool) {
    dismissKeyBoard()
    self.imagePicker = ImagePicker(viewController: self)
    self.imagePicker.delegate = self
    self.isMain = isMain
    if isMain {
      debugPrint("mainView")
    } else {
      debugPrint("minorView")
    }
  }
  
  func viewSelectLocation() {
    dismissKeyBoard()
    debugPrint("location")
    let vc = MapViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func viewUpdateHeight(height: Int, hx: Int) {
    if postViewUpdateHeight != height {
      let offsetY = height - postViewUpdateHeight
      postViewUpdateHeight = height
      let rect = CGRect(x: self.postView.frame.origin.x, y: self.postView.frame.origin.y, width: self.postView.frame.size.width, height: self.postView.frame.size.height + CGFloat(offsetY))
      debugPrint("offsetY: === \(offsetY)")
      
      // 16 为一行文字的高度
      UIView.animateWithDuration(0.5) {
        self.postView.frame = rect
        self.scrollerView.contentSize = CGSize(width: rect.width,height: rect.height)
        self.scrollerView.contentOffset.y = self.scorllerOffsetY + CGFloat(offsetY)
        self.scorllerOffsetY = self.scrollerView.contentOffset.y
      }
    }
  }
  
  func viewLittleImageViewTapped(imageViewTag: Int) {
    dismissKeyBoard()

  }
}

// MARK: - ImagePickerDelegate
extension PostViewController: ImagePickerDelegate {
  func imagePickerDidFinishPickingImage(image: UIImage) {
    let folderPath = cacheFolderPath + "/imageCaches"
    let imagePath = folderPath + "/\(timeStampInt).jpg"
    
    let data = UIImageJPEGRepresentation(image, 0.5)
    
    debugPrint("imageDataSize: === \((data?.length)!/1024)")
    do {
      try NSFileManager.defaultManager().createDirectoryAtPath(folderPath, withIntermediateDirectories: true, attributes: nil)
      data?.writeToFile(imagePath, atomically: true)
    } catch _ {}
    
    let newSize = CGSize(width: KScreenWidth - 30, height: KScreenWidth*image.size.height/image.size.width)
    
    debugPrint("newSize === \(newSize)")
    if isMain {
      images.append(image)
      postView.imageView1.image = image
    } else {
      images.append(image)
      postView.addImageViews(images)
    }
    imagesPaths.append(imagePath)
  }
}


// MARK: - LocationToolDelegate
extension PostViewController: LocationToolDelegate {
  func locationWithState(location: CLLocation, state: String) {
    locationXY = "\(state)=\(location.coordinate.latitude,location.coordinate.longitude)"
    postView.locationLabel.text = state + " (点击可以切换定位哦)"
  }
}

// MARK: - UIScrollViewDelegate
extension PostViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(scrollView: UIScrollView) {
  }
  
  func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    dismissKeyBoard()
  }
}


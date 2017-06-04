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
  var locationXY: String = "未使用定位"
  
  var postViewUpdateHeight = 35
  var scorllerOffsetY:CGFloat = 0
  
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white
    setViews()
    gainQiNiuToken()
    
    if location.isEnableLocation() {
      location.delegate = self
    } else {
      // WARNING: to do
      postView.locationLabel.text = "定位失败"
      debugPrint("定位失败")
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(dismissKeyBoard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    (tabBarController as! TabBarController).removeGestrue()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)

  }
  
  // MARK: - SetViews
  func setViews() {
    view.addSubview(BackView())
    
    view.isUserInteractionEnabled = true
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
    view.addGestureRecognizer(tapGesture)
    
    cancelBtn = {
      let btn = UIButton(type: .system)
      btn.setImage(UIImage(named: "l_close"), for: UIControlState())
      btn.tintColor = UIColor.white
      btn.addTarget(self, action: #selector(popAction), for: .touchUpInside)
      view.addSubview(btn)
      btn.snp.makeConstraints({ (make) in
        make.top.equalTo(22)
        make.left.equalTo(15)
        make.width.height.equalTo(28)
      })
      return btn
    }()
    
    postBtn = {
      let btn = BorderButton()
      btn.setTitle("发 布", for: UIControlState())
      btn.addTarget(self, action: #selector(postAction), for: .touchUpInside)
      view.addSubview(btn)
      btn.snp.makeConstraints({ (make) in
        make.centerY.equalTo(cancelBtn)
        make.right.equalTo(-15)
        make.width.equalTo(50)
        make.height.equalTo(24)
      })
      return btn
    }()
    
    scrollerView = {
      let s = UIScrollView()
      s.backgroundColor = UIColor.clear
      s.frame = CGRect(x: 0, y: 64, width: KScreenWidth, height: KScreenHeigth - 64)
      s.delegate = self
      view.addSubview(s)
      return s
    }()
    
    postView = {
      let p = PostView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 290 - 192 + (KScreenWidth - 30)*9/17))
      p.delegate = self
      scrollerView.addSubview(p)
      scrollerView.contentSize = CGSize(width: p.frame.width, height: p.frame.height + 64)
      return p
    }()
    
  }
  
  // MARK: - Methods
  func dismissKeyBoard() {
    view.endEditing(true)
    UIView.animate(withDuration: 0.3, animations: { 
      self.scrollerView.contentOffset.y = 0
    }) 
  }
  
  func popAction() {
    navigationController?.popViewController(animated: true)
  }
  
  func keyboardWillChangeFrame(_ notification: Notification) {
    let rect = (notification.userInfo![UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
    var ty:CGFloat = 0
    // 64 tableView的偏移量，第三方建盘与 y为286，原始键盘y为 352相差 66
    ty = postView.frame.origin.y + postView.frame.size.height - (rect?.origin.y)! + 64
    scorllerOffsetY = ty
    UIView.animate(withDuration: 0.3, animations: {
      self.scrollerView.contentOffset.y = ty
    })
  }
  
  func postAction() {
    debugPrint("正在发布发布")
    HUD.show("正在上传...")
    QiniuTool.upLoadImages(imagesPaths, completion: { (progress, keys) in
      debugPrint("上传进度 \(progress)")
      if progress == 1 {
        self.postToServer(keys)
      }
    }) {
      HUD.showError("图片上传失败")
      debugPrint("上传失败")
    }
  }
  
  func gainQiNiuToken() {
    PostNetTool.qiuNiuToken()
  }
  
  
  // 上传 feet 到 自己服务器上
  func postToServer(_ paths: [String]) {
    
    let newPaths = paths.map { s in
      return QNHeader + s
    }
    
    var imgs = ""
    for (index,path) in newPaths.enumerated() {
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
          HUD.showSuccess("已发布")
          debugPrint("发布结果 ===== \(str)")
          self.popAction()
        }).resolve()
      } catch where error is MyError{
        HUD.showError("\(error)")
        debugPrint("\(error)")
      } catch{
        debugPrint("网络错误")
      }
    }
  }
}

// MARK: - PostViewDelegate
extension PostViewController: PostViewDelegate {
  func viewAddImage(_ isMain: Bool) {
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
    // TODO: ....
//    let vc = MapViewController()
//    navigationController?.pushViewController(vc, animated: true)
  }
  
  func viewUpdateHeight(_ height: Int, hx: Int) {
    if postViewUpdateHeight != height {
      let offsetY = height - postViewUpdateHeight
      postViewUpdateHeight = height
      let rect = CGRect(x: self.postView.frame.origin.x, y: self.postView.frame.origin.y, width: self.postView.frame.size.width, height: self.postView.frame.size.height + CGFloat(offsetY))
      debugPrint("offsetY: === \(offsetY)")
      
      // 16 为一行文字的高度
      UIView.animate(withDuration: 0.5, animations: {
        self.postView.frame = rect
        self.scrollerView.contentSize = CGSize(width: rect.width,height: rect.height)
        self.scrollerView.contentOffset.y = self.scorllerOffsetY + CGFloat(offsetY)
        self.scorllerOffsetY = self.scrollerView.contentOffset.y
      }) 
    }
  }
  
  func viewLittleImageViewTapped(_ imageViewTag: Int) {
    dismissKeyBoard()

  }
}

// MARK: - ImagePickerDelegate
extension PostViewController: ImagePickerDelegate {
  func imagePickerDidFinishPickingImage(_ image: UIImage) {
    let folderPath = cacheFolderPath + "/imageCaches"
    let imagePath = folderPath + "/\(timeStampInt).jpg"
    
    let data = UIImageJPEGRepresentation(image, 0.5)
    
    debugPrint("imageDataSize: === \((data?.count)!/1024)")
    do {
      try FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
      try? data?.write(to: URL(fileURLWithPath: imagePath), options: [.atomic])
    } catch _ {}
    
    let newSize = CGSize(width: KScreenWidth - 30, height: KScreenWidth*image.size.height/image.size.width)
    
    debugPrint("newSize === \(newSize)")
    if isMain {
      images.removeAll()
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
  func locationWithState(_ location: CLLocation, state: String) {
    locationXY = "\(state)=\(location.coordinate.latitude,location.coordinate.longitude)"
    postView.locationLabel.text = state
  }
  
  func locationFail() {
    locationXY = "定位失败=0,0"
    postView.locationLabel.text = "定位失败"
  }
}

// MARK: - UIScrollViewDelegate
extension PostViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    dismissKeyBoard()
  }
}


//
//  ImagePicker.swift
//  QQT
//
//  Created by 张霄男 on 15/11/2.
//  Copyright © 2015年 qianshengqian.com. All rights reserved.
//

import UIKit
import Foundation
@objc
protocol ImagePickerDelegate {
  optional func imagePickerDidFinishPickingImage(image: UIImage)
}

/// 照片选取类
class ImagePicker: NSObject {
  
  var delegate: ImagePickerDelegate?
  
  let actionSheet = UIActionSheet()
  let imagePicker = UIImagePickerController()
  var viewController: UIViewController
  /// 选择照片的区域，默认300*300
  var area = CGSize(width: 300, height: 300)
  
  init(viewController: UIViewController) {
    self.viewController = viewController
    
    super.init()
    
    self.initActionSheet()
    self.initImagePicker()
  }
  
  convenience init(viewController: UIViewController, area: CGSize) {
    self.init(viewController: viewController)
    self.area = area
  }
  
  func initActionSheet() {
    actionSheet.delegate = self
    actionSheet.addButtonWithTitle("拍照")
    actionSheet.addButtonWithTitle("从手机相册选择")
    actionSheet.addButtonWithTitle("取消")
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1
    actionSheet.showInView(viewController.view)
  }
  
  func initImagePicker() {
    imagePicker.editing = true
    imagePicker.allowsEditing = true
    imagePicker.delegate = self
    imagePicker.navigationBar.barTintColor = UIColor.whiteColor()
    imagePicker.navigationBar.tintColor = .whiteColor() // Cancel button ~ any UITabBarButton items
    imagePicker.navigationBar.titleTextAttributes = [
      NSForegroundColorAttributeName : UIColor.whiteColor()
    ]
  }
}

// MARK: - UIActionSheetDelegate
extension ImagePicker: UIActionSheetDelegate {
  func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
    if buttonIndex == 0 {
      imagePicker.sourceType = .Camera
      viewController.presentViewController(imagePicker, animated: true, completion: nil)
    } else if buttonIndex == 1 {
      imagePicker.sourceType = .PhotoLibrary
      viewController.presentViewController(imagePicker, animated: true, completion: nil)
    }
  }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//    let newImage = image.imageWithSize(area)
//    delegate?.imagePickerDidFinishPickingImage?(newImage)
//    picker.dismissViewControllerAnimated(true, completion: nil)
//  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//    var imageSize = image.size
//    if imageSize.width > 1000 {
//      let width = CGFloat(1000)
//      let height = imageSize.height * width / imageSize.width
//      imageSize = CGSize(width: width, height: height)
//    }
    
    
    
    let smallImage = info[UIImagePickerControllerEditedImage] as! UIImage
    
    let imageCropRect = info[UIImagePickerControllerCropRect]?.CGRectValue()
    var imageSize = image.size
//    debugPrint("imageSize: 宽度=== \(imageSize.width) 高度 ==== \(imageSize.height)")
//    debugPrint("imageCropRect ====== \(imageCropRect)")
//    let cropRect = CGRect(x: imageCropRect!.origin.y, y: imageCropRect!.origin.x, width: imageCropRect!.size.width, height: imageCropRect!.size.height)
//    debugPrint("cropRect ====== \(cropRect)")

    delegate?.imagePickerDidFinishPickingImage?(smallImage)
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
}

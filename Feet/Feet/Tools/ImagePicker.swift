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
      imagePicker.sourceType = .SavedPhotosAlbum
      viewController.presentViewController(imagePicker, animated: true, completion: nil)
    }
  }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    let width = originalImage.size.width
    let height = originalImage.size.height

    var cutRect: CGRect!
    if width > height {
      let newWidth = height * 17 / 9
      cutRect = CGRect(x: (width - newWidth)/2, y: 0, width: newWidth, height: height)
    } else {
      let newHeight = width * 9 / 17
      cutRect = CGRect(x: 0, y: (height - newHeight)/2, width: width, height: newHeight)
    }
    
    let newImage = originalImage.cutImage(cutRect)
//    let smallImage = info[UIImagePickerControllerEditedImage] as! UIImage
//    let imageCropRect = info[UIImagePickerControllerCropRect]?.CGRectValue()

    delegate?.imagePickerDidFinishPickingImage?(newImage)
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
}

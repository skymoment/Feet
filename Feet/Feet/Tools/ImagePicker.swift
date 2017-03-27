//
//  ImagePicker.swift
//  QQT
//
//  Created by 张霄男 on 15/11/2.
//  Copyright © 2015年 qianshengqian.com. All rights reserved.
//

import UIKit
import Foundation
import AssetsLibrary
import Photos

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
//    imagePicker.editing = true
//    imagePicker.allowsEditing = true
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
      // 判断相机是否可用
      if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
        imagePicker.sourceType = .Camera
        GCDTool.delay(0.2, task: { 
          self.viewController.presentViewController(self.imagePicker, animated: true, completion: nil)
        })
      } else {
        HUD.showError(status: "未获取到相机")
      }
    } else if buttonIndex == 1 {
      imagePicker.sourceType = .SavedPhotosAlbum
      
      GCDTool.delay(0.2, task: { 
        self.viewController.presentViewController(self.imagePicker, animated: true, completion: nil)
      })
    }
  }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    debugPrint(info)
    let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    
    if picker.sourceType == .Camera {
      UIImageWriteToSavedPhotosAlbum(originalImage, self, #selector(ImagePicker.image(_:didFinishSavingWithError:contextInfo:)), nil)
    } else {
      let newImage = cutImage(originalImage)
      delegate?.imagePickerDidFinishPickingImage?(newImage)
      picker.dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
  

  
  func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
    if let err = error {
      UIAlertView(title: "错误", message: err.localizedDescription, delegate: nil, cancelButtonTitle: "确定").show()
    } else {
      getFirstPhoto({ (image) in
        let newImage = self.cutImage(image)
        self.delegate?.imagePickerDidFinishPickingImage?(newImage)
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
      })
//      let newImage = cutImage(image)
//      delegate?.imagePickerDidFinishPickingImage?(newImage)
//      imagePicker.dismissViewControllerAnimated(true, completion: nil)
   
      //      ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//      [library assetForURL:[dic objectForKey:UIImagePickerControllerReferenceURL]
//      resultBlock:^(ALAsset *asset)
//      {
//      ALAssetRepresentation *representation = [asset defaultRepresentation];
//      CGImageRef imgRef = [representation fullResolutionImage];
//      UIImage *image = [UIImage imageWithCGImage:imgRef
//      scale:representation.scale
//      orientation:(UIImageOrientation)representation.orientation];
//      NSData * data = UIImageJPEGRepresentation(image, 0.5);
//      
//      }failureBlock:^(NSError *error){
//      NSLog(@"couldn't get asset: %@", error);
//      }
//      ];

    }
  }
  
  func cutImage(originalImage: UIImage) -> UIImage {
    let width = originalImage.size.width
    let height = originalImage.size.height
    
    var cutRect: CGRect!
    if width > height {
      let newWidth = height * 17 / 9
      cutRect = CGRect(x: (width - newWidth)/2, y: 0, width: newWidth, height: height)
      let newImage = originalImage.cutImage(cutRect)
      return newImage
    } else {
      let newHeight = width * 9 / 17
      cutRect = CGRect(x: (height - newHeight)/2, y: 0, width: newHeight, height: width)
      let newImage = originalImage.cutImage(cutRect, orientation: UIImageOrientation.Right)
      return newImage
    }
  }
  
  func getFirstPhoto(compeletion: (UIImage) -> ()) {
// 获取相册
//    let results =  PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .AlbumRegular, options: nil)
//    let count = results.count
//    for i in 0 ..< count {
//      let result = results.objectAtIndex(i) as! PHAssetCollection
//      debugPrint(result.localizedTitle)
//    }
    
    let options = PHFetchOptions()
    let sort = NSSortDescriptor(key: "creationDate", ascending: false)
    options.sortDescriptors = [sort]
    let result = PHAsset.fetchAssetsWithMediaType(.Image, options: options)
    let asset = result.objectAtIndex(0) as! PHAsset
    PHImageManager().requestImageForAsset(asset, targetSize: PHImageManagerMaximumSize, contentMode: .AspectFit, options: nil) { (image, dics) in
      compeletion(image!)
    }
  }
}

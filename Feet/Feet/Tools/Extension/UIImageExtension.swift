//
//  UIImageExtension.swift
//  SwiftCocoa
//
//  Created by 王振宇 on 5/17/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

extension UIImage {
  
  /**
   Set Image With Custom Size
   
   - parameter size: custom image size
   
   - returns: the new image of new size
   */
  func imageWithSize(_ size: CGSize) -> UIImage{
    UIGraphicsBeginImageContext(size)
    self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
  }
  
  
  /**
   Set Image With Coustom Scale
   
   - parameter scale: custon image scale
   
   - returns: the new image of new scale
   */
  func imageWithScale(_ scale: CGFloat) -> UIImage {
    let newSize = CGSize(width: self.size.width * scale, height: self.size.height * scale)
    UIGraphicsBeginImageContext(newSize)
    self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
  }
  
  /**
   UIView to UIImageView
   
   - parameter view: UIView
   
   - returns: UIImage
   */
  func imageWithUIView(_ view: UIView) -> UIImage {
    UIGraphicsBeginImageContext(view.bounds.size)
    let context = UIGraphicsGetCurrentContext()
    view.layer.render(in: context!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
  
  
  /**
   cut image
   
   - parameter rect: CGRect that you want cut
   
   - returns: UIImage
   */
  func cutImage(_ rect: CGRect, orientation: UIImageOrientation? = nil) -> UIImage {
    
//    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
//    
//    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
//    
//    
//    
//    UIGraphicsBeginImageContext(smallBounds.size);
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextDrawImage(context, smallBounds, subImageRef);
//    
//    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
//    
//    UIGraphicsEndImageContext();
    
//    let newImage = UIImage(CGImage: self.CGImage!, scale: 1.0, orientation: UIImageOrientation.Left)
//  
//    let subImageRef = CGImageCreateWithImageInRect(newImage.CGImage!, rect)
//    let smallBounds = CGRectMake(0, 0, CGFloat(CGImageGetWidth(subImageRef!)), CGFloat(CGImageGetHeight(subImageRef!)))
//    UIGraphicsBeginImageContext(smallBounds.size)
//    let context = UIGraphicsGetCurrentContext()
//    CGContextDrawImage(context!, smallBounds, subImageRef!)
//    let image = UIImage(CGImage: subImageRef!)
    
    let cutImage = self.cgImage!.cropping(to: rect)
    self.imageOrientation
    if let orientation = orientation {
      let image = UIImage(cgImage: cutImage!, scale: 1.0, orientation: orientation)
      return image

    }
    return UIImage(cgImage: cutImage!)
  }
  
  func imageRotatedByDegrees(_ degree: CGFloat) -> UIImage {
    // calculate the size of the rotated view's containing box for our drawing space
    let rotatedViewBox = UIView(frame: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
    let t = CGAffineTransform(rotationAngle: degree)
    rotatedViewBox.transform = t
    let rotatedSize = rotatedViewBox.frame.size
    
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize)
    let bitmap = UIGraphicsGetCurrentContext()
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    bitmap!.translateBy(x: rotatedSize.width/2, y: rotatedSize.height/2);
    
    //   // Rotate the image context
    
    func DegreesToRadians(_ degree: CGFloat) -> CGFloat {
      return CGFloat((M_PI * Double(degree))/180)
    }
    
    bitmap!.rotate(by: DegreesToRadians(degree))
    
    // Now, draw the rotated/scaled image into the context
    bitmap!.scaleBy(x: 1.0, y: -1.0);
    bitmap!.draw(self.cgImage!, in: CGRect(x: -self.size.height / 2, y: -self.size.width / 2, width: self.size.height, height: self.size.width));
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage!;
  }
  
}



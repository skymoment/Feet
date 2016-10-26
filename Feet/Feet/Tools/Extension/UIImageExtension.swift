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
  func imageWithSize(size: CGSize) -> UIImage{
    UIGraphicsBeginImageContext(size)
    self.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
  }
  
  
  /**
   Set Image With Coustom Scale
   
   - parameter scale: custon image scale
   
   - returns: the new image of new scale
   */
  func imageWithScale(scale: CGFloat) -> UIImage {
    let newSize = CGSize(width: self.size.width * scale, height: self.size.height * scale)
    UIGraphicsBeginImageContext(newSize)
    self.drawInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
  }
  
  /**
   UIView to UIImageView
   
   - parameter view: UIView
   
   - returns: UIImage
   */
  func imageWithUIView(view: UIView) -> UIImage {
    UIGraphicsBeginImageContext(view.bounds.size)
    let context = UIGraphicsGetCurrentContext()
    view.layer.renderInContext(context!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
  
  
  /**
   cut image
   
   - parameter rect: CGRect that you want cut
   
   - returns: UIImage
   */
  func cutImage(rect: CGRect) -> UIImage {
    let cutImage = CGImageCreateWithImageInRect(self.CGImage!, rect)
    let image = UIImage(CGImage: cutImage!)
    return image
  }
  
  func imageRotatedByDegrees(degree: CGFloat) -> UIImage {
    // calculate the size of the rotated view's containing box for our drawing space
    let rotatedViewBox = UIView(frame: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
    let t = CGAffineTransformMakeRotation(degree)
    rotatedViewBox.transform = t
    let rotatedSize = rotatedViewBox.frame.size
    
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize)
    let bitmap = UIGraphicsGetCurrentContext()
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap!, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    
    func DegreesToRadians(degree: CGFloat) -> CGFloat {
      return CGFloat((M_PI * Double(degree))/180)
    }
    
    CGContextRotateCTM(bitmap!, DegreesToRadians(degree))
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap!, 1.0, -1.0);
    CGContextDrawImage(bitmap!, CGRectMake(-self.size.height / 2, -self.size.width / 2, self.size.height, self.size.width), self.CGImage!);
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage!;
  }
  
}



//
//  ImageFilter.swift
//  SwiftCocoa
//
//  Created by 王振宇 on 5/30/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation
import UIKit

/**
 *  滤镜
 */
struct ImageFilter {
  static func filterAction(image: UIImage, overColor: UIColor = UIColor.whiteColor(), alpha: CGFloat = 0.2 ,blurRadius: Double = 0.0) -> UIImage {

    // 接受一个参数并返回一个新图像
    typealias Filter = CIImage -> CIImage
    
    // 模糊
    func blur(radius: Double) -> Filter {
      return { image in
        let parameters = [
          kCIInputRadiusKey: radius,
          kCIInputImageKey: image
        ]
        guard let filter = CIFilter(name: "CIGaussianBlur",withInputParameters: parameters) else {fatalError()}
        guard let outputImage = filter.outputImage else {fatalError()}
        return outputImage
      }
    }
    
    // 在图像上面覆盖纯色叠层的滤镜，core Image默认不包含这样一个滤镜，但是可以用已经存在的滤镜来组成它
    // 颜色生成滤镜
    func colorGenerator(color: UIColor) -> Filter {
      return { _ in
        let c = CIColor(color: color)
        let parameters = [kCIInputColorKey:c]
        guard let filter = CIFilter(name: "CIConstantColorGenerator", withInputParameters: parameters) else {fatalError()}
        guard let outputImage = filter.outputImage else {fatalError()}
        return outputImage
      }
    }
    
    // 定义合成滤镜
    func compositeSourceOver(overlay: CIImage) -> Filter {
      return { image in
        let parameters = [
          kCIInputBackgroundImageKey: image,
          kCIInputImageKey: overlay
        ]
        guard let filter = CIFilter(name: "CISourceOverCompositing",withInputParameters: parameters) else {fatalError()}
        guard let outputImage = filter.outputImage else {fatalError()}
        let cropRect = image.extent
        return outputImage.imageByCroppingToRect(cropRect)
      }
    }
    
    // 结合两个滤镜
    func colorOverLay(color: UIColor) -> Filter {
      return { image in
        let overlay = colorGenerator(color)(image)
        return compositeSourceOver(overlay)(image)
      }
    }
    
    let image = CIImage(image: image)
    let overlayColor = overColor.colorWithAlphaComponent(alpha)
    let blurredImage = blur(blurRadius)(image!)
    let overlaidImage = colorOverLay(overlayColor)(blurredImage)
    
    return UIImage(CIImage: overlaidImage)
  }
}

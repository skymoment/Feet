//
//  MineTableHeader.swift
//  Feet
//
//  Created by 王振宇 on 7/10/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class MineTableHeader: UIView {
  
  private var Vline: CGFloat = 0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clearColor()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func drawRect(rect: CGRect) {
    //获取画笔上下文
    let context:CGContextRef = UIGraphicsGetCurrentContext()!
    //设置画笔的颜色
    CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
    //抗锯齿设置
    CGContextSetAllowsAntialiasing(context, true)
    
    //画直线  height = 40
    CGContextSetLineWidth(context, 2) //设置画笔的宽度
    CGContextMoveToPoint(context, 0, rect.height/2)
    CGContextAddLineToPoint(context, 15, rect.height/2)
    CGContextStrokePath(context)  //关闭路径
    
    let str:NSString = "时间轴"
    let attrs = [NSFontAttributeName: UIFont.systemFontOfSize(20),NSForegroundColorAttributeName: UIColor.whiteColor()]
    let newSize = str.sizeWithAttributes(attrs)
    str.drawAtPoint(CGPoint(x: 15 + 8, y: 8), withAttributes: attrs)
    
    //画直线
    CGContextSetLineWidth(context, 2) //设置画笔的宽度
    CGContextMoveToPoint(context, 15 + 8 + newSize.width + 8, rect.height/2)
    CGContextAddLineToPoint(context, rect.width, rect.height/2)
    CGContextStrokePath(context)  //关闭路径
    
    //画直线
    debugPrint("竖线位置X: \(15 + 8 + newSize.width + 8 + 15)")
    Vline = 15 + 8 + newSize.width + 8 + 15
    CGContextSetLineWidth(context, 2) //设置画笔的宽度
    CGContextMoveToPoint(context, 15 + 8 + newSize.width + 8 + 15, rect.height/2)
    CGContextAddLineToPoint(context, 15 + 8 + newSize.width + 8 + 15, rect.height)
    CGContextStrokePath(context)  //关闭路径
  }
  
  func vline() -> CGFloat {
    return Vline
  }
}

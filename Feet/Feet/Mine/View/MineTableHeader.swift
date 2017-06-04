//
//  MineTableHeader.swift
//  Feet
//
//  Created by 王振宇 on 7/10/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class MineTableHeader: UIView {
  
  fileprivate var Vline: CGFloat = 0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clear
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func draw(_ rect: CGRect) {
    //获取画笔上下文
    let context:CGContext = UIGraphicsGetCurrentContext()!
    //设置画笔的颜色
    context.setStrokeColor(UIColor.white.cgColor)
    //抗锯齿设置
    context.setAllowsAntialiasing(true)
    
    //画直线  height = 40
    context.setLineWidth(2) //设置画笔的宽度
    context.move(to: CGPoint(x: 0, y: rect.height/2))
    context.addLine(to: CGPoint(x: 15, y: rect.height/2))
    context.strokePath()  //关闭路径
    
    let str:NSString = "时间轴"
    let attrs = [NSFontAttributeName: UIFont.systemFont(ofSize: 20),NSForegroundColorAttributeName: UIColor.white]
    let newSize = str.size(attributes: attrs)
    str.draw(at: CGPoint(x: 15 + 8, y: 8), withAttributes: attrs)
    
    //画直线
    context.setLineWidth(2) //设置画笔的宽度
    context.move(to: CGPoint(x: 15 + 8 + newSize.width + 8, y: rect.height/2))
    context.addLine(to: CGPoint(x: rect.width, y: rect.height/2))
    context.strokePath()  //关闭路径
    
    //画直线
    debugPrint("竖线位置X: \(15 + 8 + newSize.width + 8 + 15)")
    Vline = 15 + 8 + newSize.width + 8 + 15
    context.setLineWidth(2) //设置画笔的宽度
    context.move(to: CGPoint(x: 15 + 8 + newSize.width + 8 + 15, y: rect.height/2))
    context.addLine(to: CGPoint(x: 15 + 8 + newSize.width + 8 + 15, y: rect.height))
    context.strokePath()  //关闭路径
  }
  
  func vline() -> CGFloat {
    return Vline
  }
}

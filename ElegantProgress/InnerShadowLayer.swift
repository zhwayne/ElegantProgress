//
//  InnerShadowLayer.swift
//  InnerShadowLayer
//
//  Created by wayne on 15/6/13.
//  Copyright © 2015年 wayne. All rights reserved.
//

import UIKit

class InnerShadowLayer: CALayer {
    var innerShadowColor: CGColor? = UIColor.blackColor().CGColor {
        didSet {
            setNeedsDisplay()
        }
    }
    var innerShadowOffset: CGSize = CGSizeMake(0, 0) {
        didSet {
            setNeedsDisplay()
        }
    }
    var innerShadowRadius: CGFloat = 8 {
        didSet {
            setNeedsDisplay()
        }
    }
    var innerShadowOpacity: Float = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        self.masksToBounds      = true
        self.shouldRasterize    = true
        self.contentsScale      = UIScreen.mainScreen().scale
        self.rasterizationScale = UIScreen.mainScreen().scale
        
        setNeedsDisplay()
    }
    
    override func drawInContext(ctx: CGContext) {
        print("draw")
        // 设置 Context 属性
        // 允许抗锯齿
        CGContextSetAllowsAntialiasing(ctx, true);
        // 允许平滑
        CGContextSetShouldAntialias(ctx, true);
        // 设置插值质量
        CGContextSetInterpolationQuality(ctx, CGInterpolationQuality.High);
        
        // 以下为核心代码
        
        // 创建 color space
        let colorspace = CGColorSpaceCreateDeviceRGB();
        
        var rect   = self.bounds
        var radius = self.cornerRadius
        
        // 去除边框的大小
        if self.borderWidth != 0 {
            rect   = CGRectInset(rect, self.borderWidth, self.borderWidth);
            radius -= self.borderWidth
            radius = max(radius, 0)
        }
        
        // 创建 inner shadow 的镂空路径
        let someInnerPath: CGPathRef = UIBezierPath(roundedRect: rect, cornerRadius: radius).CGPath
        CGContextAddPath(ctx, someInnerPath)
        CGContextClip(ctx)
        
        // 创建阴影填充区域，并镂空中心
        let shadowPath = CGPathCreateMutable()
        let shadowRect = CGRectInset(rect, -rect.size.width, -rect.size.width)
        CGPathAddRect(shadowPath, nil, shadowRect)
        CGPathAddPath(shadowPath, nil, someInnerPath);
        CGPathCloseSubpath(shadowPath)
        
        // 获取填充颜色信息
        let oldComponents: UnsafePointer<CGFloat> = CGColorGetComponents(self.innerShadowColor)
        var newComponents:[CGFloat] = [0, 0, 0, 0]
        let numberOfComponents: Int = CGColorGetNumberOfComponents(self.innerShadowColor);
        switch (numberOfComponents){
        case 2:
            // 灰度
            newComponents[0] = oldComponents[0]
            newComponents[1] = oldComponents[0]
            newComponents[2] = oldComponents[0]
            newComponents[3] = oldComponents[1] * CGFloat(self.innerShadowOpacity)
        case 4:
            // RGBA
            newComponents[0] = oldComponents[0]
            newComponents[1] = oldComponents[1]
            newComponents[2] = oldComponents[2]
            newComponents[3] = oldComponents[3] * CGFloat(self.innerShadowOpacity)
        default: break
        }
        
        // 根据颜色信息创建填充色
        let innerShadowColorWithMultipliedAlpha = CGColorCreate(colorspace, newComponents)
        
        // 填充阴影
        CGContextSetFillColorWithColor(ctx, innerShadowColorWithMultipliedAlpha)
        CGContextSetShadowWithColor(ctx, self.innerShadowOffset, self.innerShadowRadius, innerShadowColorWithMultipliedAlpha)
        CGContextAddPath(ctx, shadowPath)
        CGContextEOFillPath(ctx)
    }
}

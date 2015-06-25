//
//  ElegantProgressView.swift
//  ElegantProgress
//
//  Created by wayne on 15/6/17.
//  Copyright © 2015年 wayne. All rights reserved.
//

import UIKit

class ElegantProgressView: UIView {
    private var textLabel: UILabel!
    private var progressLayer: CAShapeLayer!
    
    var progress:CGFloat {
        get { return progressLayer.strokeEnd }
        set{
            var realValue = newValue
            if realValue < CGFloat.min {
                realValue = CGFloat.min
            }
                        
            CATransaction.begin()
            CATransaction.setDisableActions(false)
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
            CATransaction.setAnimationDuration(0.001)
            progressLayer.strokeEnd = realValue
            CATransaction.commit()
            
            if realValue <= CGFloat.min {
                textLabel.text = "Waiting..."
            }
            else if realValue == 1 {
                textLabel.text = "Done"
            }
            else {
                textLabel.text = NSString(format: "%.f%%", realValue * 100) as String
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.hexColor(0xeff8f3)
        
        /* 添加圆角 */
        self.layer.masksToBounds = true
        self.layer.cornerRadius  = self.bounds.width / 2
        
        // 添加 layers
        self.layoutSublayers()
    }

    private func layoutSublayers() {
        
        func addBottom() {  // 给底盘添加黑色和白色的内阴影
            
            let topLeftShadowLayer                    = InnerShadowLayer()
            topLeftShadowLayer.frame                  = CGRectInset(self.bounds, -1.5, -1.5)
            topLeftShadowLayer.cornerRadius           = topLeftShadowLayer.bounds.width / 2
            topLeftShadowLayer.innerShadowOpacity     = 0.5
            topLeftShadowLayer.innerShadowRadius      = 5
            topLeftShadowLayer.innerShadowOffset      = CGSizeMake(1.6, 1.6)
            self.layer.addSublayer(topLeftShadowLayer)
            
            let bottomRightShadowLayer               = InnerShadowLayer()
            bottomRightShadowLayer.frame             = CGRectInset(self.bounds, -0.5, -0.5)
            bottomRightShadowLayer.cornerRadius      = bottomRightShadowLayer.bounds.width / 2
            bottomRightShadowLayer.innerShadowColor  = UIColor.whiteColor().CGColor
            bottomRightShadowLayer.innerShadowRadius = 1
            bottomRightShadowLayer.innerShadowOffset = CGSizeMake(-0.5, -0.5)
            self.layer.addSublayer(bottomRightShadowLayer)
            
        }
        addBottom()
        
        
        func addMiddle() {
            
            let middleRectInset         = layer.bounds.width * 0.1
            
            let middleLayer             = CAShapeLayer()
            middleLayer.frame           = CGRectInset(layer.bounds, middleRectInset, middleRectInset)
            middleLayer.cornerRadius    = middleLayer.bounds.width / 2
            middleLayer.backgroundColor = UIColor.clearColor().CGColor
            
            middleLayer.shouldRasterize    = true
            middleLayer.contentsScale      = UIScreen.mainScreen().scale
            middleLayer.rasterizationScale = UIScreen.mainScreen().scale
            middleLayer.shadowColor        = UIColor.blackColor().CGColor
            middleLayer.shadowOffset       = CGSizeMake(2, 6)    // 注意比例
            middleLayer.shadowRadius       = 5
            middleLayer.shadowOpacity      = 0.3
            
            self.layer.addSublayer(middleLayer)
            
            /******************************************************************/
            
            let gradientLayer          = CAGradientLayer()
            gradientLayer.frame        = CGRectInset(middleLayer.bounds, -0.2, -0.2)
            gradientLayer.cornerRadius = gradientLayer.bounds.width / 2
            gradientLayer.colors       = [UIColor.hexColor(0xf8fdfa).CGColor, UIColor.hexColor(0xc1cbc6).CGColor]
            gradientLayer.locations    = [-0.15, 0.75]
            gradientLayer.startPoint   = CGPointMake(0.25, 0)
            gradientLayer.endPoint     = CGPointMake(0.75, 1)
            middleLayer.addSublayer(gradientLayer)
            
            /******************************************************************/
            
            let bottomRightShadowLayer                = InnerShadowLayer()
            bottomRightShadowLayer.frame              = CGRectInset(gradientLayer.bounds, -2, -2)
            bottomRightShadowLayer.cornerRadius       = bottomRightShadowLayer.bounds.width / 2
            bottomRightShadowLayer.innerShadowOffset  = CGSizeMake(-10, -10)
            bottomRightShadowLayer.innerShadowOpacity = 0.3
            bottomRightShadowLayer.innerShadowRadius  = 18
            gradientLayer.masksToBounds               = true
            gradientLayer.addSublayer(bottomRightShadowLayer)
            
            /******************************************************************/
            
            let topLeftShadowLayer               = InnerShadowLayer()
            topLeftShadowLayer.frame             = CGRectInset(gradientLayer.bounds, -1, -1)
            topLeftShadowLayer.cornerRadius      = topLeftShadowLayer.bounds.width / 2
            topLeftShadowLayer.innerShadowColor  = UIColor.whiteColor().CGColor
            topLeftShadowLayer.innerShadowRadius = 1.5
            topLeftShadowLayer.innerShadowOffset = CGSizeMake(0.3, 0.9)
            gradientLayer.addSublayer(topLeftShadowLayer)
            
        }
        addMiddle()
        
        
        func addTop() {
            
            let topRectInset  = layer.bounds.width * 0.25
            
            let topLayer             = CAShapeLayer()
            topLayer.frame           = CGRectInset(layer.bounds, topRectInset, topRectInset)
            topLayer.cornerRadius    = topLayer.bounds.width / 2
            topLayer.backgroundColor = UIColor.hexColor(0xd5ddd9).CGColor
            topLayer.masksToBounds   = true;
            
            self.layer.addSublayer(topLayer)
            
            /******************************************************************/
            
            let bottomRightShadowLayer                = InnerShadowLayer()
            bottomRightShadowLayer.frame              = topLayer.bounds
            bottomRightShadowLayer.cornerRadius       = bottomRightShadowLayer.bounds.width / 2
            bottomRightShadowLayer.innerShadowColor   = UIColor.whiteColor().CGColor
            bottomRightShadowLayer.innerShadowOffset  = CGSizeMake(-1, -1)
            bottomRightShadowLayer.innerShadowRadius  = 2
            bottomRightShadowLayer.innerShadowOpacity = 0.6

            topLayer.addSublayer(bottomRightShadowLayer)

            /******************************************************************/

            let topLeftShadowLayer                = InnerShadowLayer()
            topLeftShadowLayer.frame              = topLayer.bounds
            topLeftShadowLayer.cornerRadius       = topLeftShadowLayer.bounds.width / 2
            topLeftShadowLayer.innerShadowRadius  = 15
            topLeftShadowLayer.innerShadowOpacity = 0.2
            topLeftShadowLayer.innerShadowOffset  = CGSizeMake(3, 9)

            topLayer.addSublayer(topLeftShadowLayer)
            
        }
        addTop()
        
        
        func addTextLabel() {
            
            let textRectInset  = layer.bounds.width * 0.3
            let frame          = CGRectInset(self.bounds, textRectInset, textRectInset)
            
            textLabel               = UILabel(frame: frame)
            textLabel.text          = "Waiting..."
            textLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 32)
            textLabel.textColor     = UIColor.hexColor(0x97aea6)
            textLabel.textAlignment = NSTextAlignment.Center
            textLabel.adjustsFontSizeToFitWidth = true
            self.addSubview(textLabel)
            
        }
        addTextLabel()
        
        
        func addProgress() {
            
            let gradientLayer          = CAGradientLayer()
            gradientLayer.frame        = layer.bounds
            gradientLayer.cornerRadius = gradientLayer.bounds.width / 2
            gradientLayer.colors       = [UIColor.hexColor(0x70dc98).CGColor, UIColor.hexColor(0x70dcbf).CGColor]
            gradientLayer.locations    = [0, 1]
            gradientLayer.startPoint   = CGPointMake(0.25, 0)
            gradientLayer.endPoint     = CGPointMake(0.75, 1)
            
            layer.insertSublayer(gradientLayer, atIndex: 0)
            
            
            let middleRectInset = layer.bounds.width * 0.1
            let path            = UIBezierPath(arcCenter: layer.position, radius: (layer.bounds.width - middleRectInset) / 2, startAngle: CGFloat(angle: -90), endAngle: CGFloat(angle: 270), clockwise: true).CGPath
            
            progressLayer             = CAShapeLayer()
            progressLayer.frame       = CGRectInset(layer.bounds, layer.borderWidth, layer.borderWidth)
            progressLayer.fillColor   = UIColor.clearColor().CGColor
            progressLayer.strokeColor = UIColor.hexColor(0x70dc98).CGColor
            progressLayer.opacity     = 0.8
            progressLayer.lineCap     = kCALineCapRound
            progressLayer.lineWidth   = middleRectInset
            progressLayer.path        = path
            progressLayer.strokeEnd   = CGFloat.min
            
            gradientLayer.mask = progressLayer
            
        }
        addProgress()
    }
}


extension CGFloat {
    init(angle: CGFloat) {
        self = angle * CGFloat(M_PI) / 180.0
    }
}

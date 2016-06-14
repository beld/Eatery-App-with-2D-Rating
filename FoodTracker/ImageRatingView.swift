//
//  RatingViewController.swift
//  LxThroughPointsBezier-Swift
//
//  Created by Ding on 4/12/16.
//  Copyright © 2016 Gener-health-li.x. All rights reserved.
//

import UIKit

class ImageRatingView: UIImageView {
    
    let vertiLine = UIBezierPath()
    let horiLine = UIBezierPath()
    let vertiShapeLayer = CAShapeLayer()
    let horiShapeLayer = CAShapeLayer()
    let startPoint = CGPoint(x: 10, y: 10)
    let endPoint = CGPoint(x: 300, y: 300)
    var midPointX: CGFloat
    var midPointY: CGFloat
    
    let movingPointView = PointView.aInstance()
    var label = UILabel(frame: CGRectMake(0, 0, 85, 21))
    
    required init?(coder aDecoder: NSCoder) {
        
        midPointX = (startPoint.x + endPoint.x) / 2
        midPointY = (startPoint.y + endPoint.y) / 2
        
        super.init(coder: aDecoder)
        
        let control = UIControl()
        control.addTarget(self, action: #selector(ImageRatingView.valueChanged), forControlEvents: .ValueChanged)
        
        movingPointView.center.x = midPointX
        movingPointView.center.y = midPointY
        movingPointView.dragCallBack = { [unowned self] (pointView: PointView) -> Void in
            self.valueChanged(control)
        }
        self.addSubview(movingPointView)

        let x = Float(movingPointView.center.x / (endPoint.x - startPoint.x))
        let y = Float(1 - movingPointView.center.y / (endPoint.y - startPoint.y))
        label.text = String(format: ("(%.0f, %.0f)"), (x - 0.034) * 100 , (y + 0.035) * 100)
        label.center = CGPointMake(movingPointView.center.x, movingPointView.center.y + 25)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        addSubview(label)

        vertiShapeLayer.path = vertiLine.CGPath
        vertiShapeLayer.strokeColor = UIColor(white: 1, alpha: 0.5).CGColor
        vertiShapeLayer.fillColor = nil
        vertiShapeLayer.lineWidth = 2
        vertiShapeLayer.lineCap = kCALineCapRound
        self.layer.addSublayer(vertiShapeLayer)
        horiShapeLayer.path = horiLine.CGPath
        horiShapeLayer.strokeColor = UIColor(white: 1, alpha: 0.5).CGColor
        horiShapeLayer.fillColor = nil
        horiShapeLayer.lineWidth = 2
        horiShapeLayer.lineCap = kCALineCapRound
        self.layer.addSublayer(horiShapeLayer)
    }
    
    func valueChanged(control: UIControl) {
        
        vertiLine.removeAllPoints()
        horiLine.removeAllPoints()
        
        if movingPointView.center.x > endPoint.x {
            movingPointView.center.x = endPoint.x
        }
        if movingPointView.center.x  < startPoint.x {
            movingPointView.center.x  = startPoint.x
        }
        if movingPointView.center.y > endPoint.y {
            movingPointView.center.y = endPoint.y
        }
        if movingPointView.center.y < startPoint.y {
            movingPointView.center.y = startPoint.y
        }
        
        vertiLine.moveToPoint(CGPoint(x: startPoint.x, y: movingPointView.center.y))
        vertiLine.addLineToPoint(CGPoint(x: endPoint.x, y: movingPointView.center.y))
        horiLine.moveToPoint(CGPoint(x: movingPointView.center.x, y: endPoint.y))
        horiLine.addLineToPoint(CGPoint(x: movingPointView.center.x, y: startPoint.y))
        vertiShapeLayer.path = vertiLine.CGPath
        horiShapeLayer.path = horiLine.CGPath
        
        let x = Float(movingPointView.center.x / (endPoint.x - startPoint.x))
        let y = Float(1 - movingPointView.center.y / (endPoint.y - startPoint.y))
        label.text = String(format: ("(%.0f, %.0f)"), (x - 0.034) * 100 , (y + 0.035) * 100)
        label.center = CGPointMake(movingPointView.center.x, movingPointView.center.y + 25)
    }
    
    func getRatingScale() -> (CGFloat, CGFloat) {
        let x = movingPointView.center.x / (endPoint.x - startPoint.x)
        let y = 1 - movingPointView.center.y / (endPoint.y - startPoint.y)
        return ((x - 0.034) , (y + 0.035))
    }
}

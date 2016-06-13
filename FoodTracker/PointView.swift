//
//  PointView.swift
//  LxThroughPointsBezier-Swift
//

import UIKit

private let RADIUS: CGFloat = 15

class PointView: UIControl {

    class func aInstance() -> PointView {
        
        let aInstance = PointView(frame: CGRect(origin: CGPointZero, size: CGSize(width: RADIUS * 2, height: RADIUS * 2)))
        aInstance.layer.cornerRadius = RADIUS
        aInstance.layer.masksToBounds = true
        aInstance.layer.borderWidth = 3.0
        aInstance.layer.borderColor = UIColor.whiteColor().CGColor
        aInstance.backgroundColor = UIColor.cyanColor()
        aInstance.addTarget(aInstance, action: #selector(PointView.touchDragInside(_:withEvent:)), forControlEvents: .TouchDragInside)
        return aInstance
    }
    
    var dragCallBack = { (pointView: PointView) -> Void in }
    
    func touchDragInside(pointView: PointView, withEvent event: UIEvent) {
    
        for touch in event.allTouches()! {
        
            pointView.center = (touch ).locationInView(superview)
            dragCallBack(self)
            return
        }        
    }
}

//
//  RatingViewController.swift
//  Eatery 2D
//
//  Created by Ding on 6/14/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

protocol Delegate: class {
    func didPressSaveButton(vertiRating: CGFloat, horiRating: CGFloat) -> Bool
}

class RatingViewController: UIViewController {

    @IBOutlet weak var imageRatingView: ImageRatingView!
    @IBOutlet weak var horiLabel: UILabel!
    weak var delegate: Delegate?
    var ratingContent: String!
    var horiRating: CGFloat = 0.0
    var vertiRating: CGFloat = 0.0
    var vertiLabel: UILabel!
    var vertiContent: String!
    var horiContent: String!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.lt_setBackgroundColor(UIColor(red: 1/255.0, green: 131/255.0, blue: 209/255.0, alpha: 1))
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController!.navigationBar.titleTextAttributes =
            ([NSFontAttributeName: UIFont(name: "ChalkboardSE-Bold", size: 17)!,
                NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        imageRatingView.image = self.image
        vertiLabel = UILabel(frame: CGRectMake(0, 0, 320, 21))
        vertiLabel.textAlignment = NSTextAlignment.Center
        vertiLabel.font = UIFont(name: "ChalkboardSE-regular", size: 18)
        vertiLabel.textColor = UIColor.darkGrayColor()
        horiLabel.textColor = UIColor.darkGrayColor()
        horiLabel.text = horiContent
        vertiLabel.text = vertiContent
        self.view.addSubview(vertiLabel)
        vertiLabel.layer.anchorPoint = CGPointMake(0.0, 0.0)
        vertiLabel.transform = CGAffineTransformMakeRotation( CGFloat(M_PI) / 2 )
        vertiLabel.frame = CGRectMake(28, 64.5, 21, 320)
        
        
        imageRatingView.movingPointView.center.x = horiRating * 290 + 10
        imageRatingView.movingPointView.center.y = 300 - vertiRating * 290
        imageRatingView.vertiLine.moveToPoint(CGPoint(x: imageRatingView.startPoint.x, y: imageRatingView.movingPointView.center.y))
        imageRatingView.vertiLine.addLineToPoint(CGPoint(x: imageRatingView.endPoint.x, y: imageRatingView.movingPointView.center.y))
        imageRatingView.horiLine.moveToPoint(CGPoint(x: imageRatingView.movingPointView.center.x, y: imageRatingView.endPoint.y))
        imageRatingView.horiLine.addLineToPoint(CGPoint(x: imageRatingView.movingPointView.center.x, y: imageRatingView.startPoint.y))
        imageRatingView.vertiShapeLayer.path = imageRatingView.vertiLine.CGPath
        imageRatingView.horiShapeLayer.path = imageRatingView.horiLine.CGPath
        
        let x = Float(imageRatingView.movingPointView.center.x / (imageRatingView.endPoint.x - imageRatingView.startPoint.x))
        let y = Float(1 - imageRatingView.movingPointView.center.y / (imageRatingView.endPoint.y - imageRatingView.startPoint.y))
        imageRatingView.label.text = String(format: ("(%.0f, %.0f)"), (x - 0.034) * 100 , (y + 0.035) * 100)
        imageRatingView.label.center = CGPointMake(imageRatingView.movingPointView.center.x, imageRatingView.movingPointView.center.y + 25)
    }
    
    @IBAction func saveRating(sender: AnyObject) {
        (horiRating, vertiRating) = imageRatingView.getRatingScale()
        if let success = delegate?.didPressSaveButton(vertiRating, horiRating: horiRating) where success {
        }
        navigationController?.popViewControllerAnimated(true)
    }
}

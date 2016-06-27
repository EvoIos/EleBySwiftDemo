//
//  StarsView.swift
//  SwiftTestDemoBySwift
//
//  Created by z on 16/6/3.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class StarsView: UIView {
    let maxStars: CGFloat = 5.0
    
    var grayImgView: UIImageView!
    var orangeImgView: UIImageView!
    
    var maskLayer: CAShapeLayer!
    var path: UIBezierPath!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        clipsToBounds = true
        
        maskLayer = CAShapeLayer()
        path = UIBezierPath(rect: CGRectMake(0, 0, 0, 13))
        maskLayer.path = path.CGPath
        maskLayer.fillColor = UIColor.whiteColor().CGColor;
        
        
        grayImgView = UIImageView(frame: CGRectMake(0, (bounds.size.height - 13) / 2.0, 73, 13))
        orangeImgView = UIImageView(frame: CGRectMake(0, (bounds.size.height - 13) / 2.0, 73, 13))
        
        grayImgView.contentMode = .ScaleToFill
        grayImgView.image = UIImage(named: "gray")
        orangeImgView.contentMode = .ScaleToFill
        orangeImgView.image = UIImage(named: "orange")
        
        addSubview(grayImgView)
        addSubview(orangeImgView)
        
        orangeImgView.layer.mask = maskLayer
    }
    
    func setStars(stars: CGFloat) {
        if stars > maxStars {
            return
        }
       
        var width = frame.size.width
        width =  stars/maxStars * width
        
        path =  UIBezierPath(rect: CGRectMake(0, 0, width, 13))
        maskLayer.path = path.CGPath
        orangeImgView.layer.mask = maskLayer
    
    }
}

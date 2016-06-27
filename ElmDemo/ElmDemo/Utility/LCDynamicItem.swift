//
//  LCDynamicItem.swift
//  ElmDemo
//
//  Created by zhenglanchun on 16/6/19.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class LCDynamicItem: NSObject, UIDynamicItem {
    //MARK: UIDynamicItem protocol
    var center: CGPoint = CGPointZero
    var transform: CGAffineTransform = CGAffineTransformIdentity
    var bounds: CGRect
    override init() {
        self.bounds = CGRectMake(0, 0, 1, 1)
    }
}

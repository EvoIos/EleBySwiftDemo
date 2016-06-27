//
//  SeparatorLineView.swift
//  ElmDemo
//
//  Created by z on 16/5/30.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class SeparatorLineView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = SEPARATOR_COLOR
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = SEPARATOR_COLOR
    }
    
}

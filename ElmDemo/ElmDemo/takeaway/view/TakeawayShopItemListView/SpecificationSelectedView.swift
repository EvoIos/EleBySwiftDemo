//
//  SpecificationSelectedView.swift
//  ElmDemo
//
//  Created by z on 16/6/23.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class SpecificationSelectedView: UIView {
    typealias SelectedViewCancelButtonClicked = (UIButton) -> ()
    typealias SelectedViewConfirmButtonClicked = (UIButton) -> ()
    var cancelButtonClicked: SelectedViewCancelButtonClicked?
    var confirmButtonClicked: SelectedViewConfirmButtonClicked?
    
    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    @IBAction func cancelButtonAction(sender: UIButton) {
        cancelButtonClicked?(sender)
    }
    
    @IBAction func resultButtonAction(sender: UIButton) {
        confirmButtonClicked?(sender)
    }
    
    
    func  xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "\(self.dynamicType)", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }


    
}

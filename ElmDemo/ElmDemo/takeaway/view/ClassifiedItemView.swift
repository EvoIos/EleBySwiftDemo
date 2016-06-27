//
//  ClassifiedItemView.swift
//  ElmDemo
//
//  Created by z on 16/5/30.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit
protocol ClassifiedItemViewDelegate {
    //view's tag
    func clickedButton(currentTag: Int)
}

@IBDesignable class ClassifiedItemView: UIView {
    var view: UIView!
    
    var delegate: ClassifiedItemViewDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func tapBtn(sender: UIButton) {
        self.delegate?.clickedButton(tag)
        
    }
    
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }

    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    @IBInspectable var image: UIImage? {
        get {
            return imageView.image
        }
        set(image) {
            imageView.image = image
        }
    }
    
    @IBInspectable var title: String? {
        get {
            return titleLabel.text
        }
        set(title) {
            titleLabel.text = title
        }
    }

    func  xibSetup() {
        view = loadViewFromNib()
        
        //use bounds not frame
        view.frame = bounds
        
        //make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "ClassifiedItemView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
}

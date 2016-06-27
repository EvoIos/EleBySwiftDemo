//
//  LCFileterButton.swift
//  ElmDemo
//
//  Created by zhenglanchun on 16/6/4.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

protocol LCFileterButtonDelegate {
    func tapButtonWithCurrentTag(currentBtn: UIButton, currentTag: Int)
    
}

@IBDesignable class LCFileterButton: UIView {
    
    //MARK: - public 
    var delegate: LCFileterButtonDelegate?
    
    func updateUI(sender: UIButton) {
        if sender.selected {
            titleLabel.textColor = UIColor(red: 45.0/255.0, green: 146.0/255.0, blue: 225.0/255.0, alpha: 1)
            imgView.image = UIImage(named: "向上箭头")
        } else {
            titleLabel.textColor = UIColor.blackColor()
            imgView.image = UIImage(named: "向下箭头")
        }
    }
    
    //MARK: - private
    var view: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBInspectable var title: String? {
        get {
            return titleLabel.text
        }
        set(title) {
            titleLabel.text = title
        }
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        sender.selected = !sender.selected
        updateUI(sender)
        self.delegate?.tapButtonWithCurrentTag(sender, currentTag: tag)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let newTitle = title {
            titleLabel.text = newTitle
        }
        imgView.image = UIImage(named: "向下箭头")
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "LCFileterButton", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }

    
       
}

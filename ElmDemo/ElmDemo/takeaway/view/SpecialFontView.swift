//
//  SpecialFontView.swift
//  ExpandCellDemo
//
//  Created by zhenglanchun on 16/5/31.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class SpecialFontView: UIView {

    @IBOutlet weak var specialLab: UILabel!

    @IBOutlet weak var detailLab: UILabel!
    
    var view: UIView!
    
    func setViewDetails(specialLabText specialLabText: String,detailLabText :String) {
        specialLab.text = specialLabText
        detailLab.text = detailLabText
        
        if specialLabText.hasPrefix("首") {
            specialLab.backgroundColor = firstLabBGColor
        }
        if specialLabText.hasPrefix("减") {
            specialLab.backgroundColor = MinusLabBGColor
        }
        if specialLabText.hasPrefix("专") {
            specialLab.backgroundColor = SpecialLabBGColor
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    
    func  xibSetup() {
        
        view = loadViewFromNib()
        
        addSubview(view)
        
        self.specialLab.layer.cornerRadius = 3
        
        
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "SpecialFontView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    
}


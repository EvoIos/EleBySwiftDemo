//
//  ShopFilterListCell.swift
//  SwiftTestDemoBySwift
//
//  Created by z on 16/6/3.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class ShopFilterListCell: UITableViewCell {

    
    @IBOutlet weak var shopItemImgView: UIImageView!
    
    @IBOutlet weak var shopCategoryNameLab: UILabel!
    
    @IBOutlet weak var shopItemCopiesLab: UILabel!
    
    @IBOutlet weak var countLabWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shopItemCopiesLab.backgroundColor = UIColor(red: 207.0/255.0, green: 207.0/255.0, blue: 207.0/255.0, alpha: 1)
        shopItemCopiesLab.layer.cornerRadius = 6.5
        
        shopItemCopiesLab.sizeToFit()
        let width = shopItemCopiesLab.frame.size.width
        countLabWidthConstraint.constant = width + 10
       
        contentView.backgroundColor = SHOPFILTERCELLBG_COLOR
    }
    
    func setModel(model: Categoryallinfo) {
        shopItemImgView.image = UIImage(named: model.categorImg)
        shopCategoryNameLab.text = model.categoryName
        shopItemCopiesLab.text = "\(model.categoryTotalCount)"
    }

    func setBGColorWithSelectedState(selected: Bool) {
        if selected == true {
            contentView.backgroundColor = UIColor.whiteColor()
        } else {
            contentView.backgroundColor = SHOPFILTERCELLBG_COLOR
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

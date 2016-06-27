//
//  ShopItemDetailCell.swift
//  ElmDemo
//
//  Created by zhenglanchun on 16/6/24.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class ShopItemDetailCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    
    var firstCellFlag: Bool? {
        get {
            return self.firstCellFlag
        }
        set(firstCellFlag) {
            containerView.hidden = firstCellFlag!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstCellFlag = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  OrderDetailHeadCell.swift
//  ElmDemo
//
//  Created by z on 16/6/25.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class OrderDetailHeadCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor(red: 75.0/255.0, green: 161.0/255.0, blue: 228.0/255.0, alpha: 1)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

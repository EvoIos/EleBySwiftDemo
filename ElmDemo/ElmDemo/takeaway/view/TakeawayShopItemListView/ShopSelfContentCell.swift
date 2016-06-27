//
//  ShopSelfContentCell.swift
//  ElmDemo
//
//  Created by z on 16/6/25.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class ShopSelfContentCell: UITableViewCell {

    var showContainerView: Bool {
        get {
            return self.showContainerView
        }
        set(showContainerView) {
            print("bool: \(showContainerView)")
            self.containerView.hidden = !showContainerView
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

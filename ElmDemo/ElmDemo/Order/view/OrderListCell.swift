//
//  OrderListCell.swift
//  ElmDemo
//
//  Created by z on 16/6/25.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class OrderListCell: UITableViewCell {
    
    typealias ShopButtonClicked = () -> ()
    typealias OrderButtonClicked = () -> ()

    var shopButtonClicked: ShopButtonClicked?
    var orderButtonClicked: OrderButtonClicked?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func deleteButtonAction(sender: AnyObject) {
        
    }
    
    @IBAction func shopButtonAction(sender: AnyObject) {
        shopButtonClicked?()
    }
    
    @IBAction func orderButtonAction(sender: AnyObject) {
        orderButtonClicked?()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

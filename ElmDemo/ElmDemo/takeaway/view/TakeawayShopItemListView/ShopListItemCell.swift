//
//  ShopListItemCell.swift
//  ElmDemo
//
//  Created by z on 16/6/21.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class ShopListItemCell: UITableViewCell {
    //点击规格
    typealias ShopListItemSpecificationButtonClicked = (UIButton) -> ()
    //点击+ - 按钮
    typealias ShopListItemAddOrMinusButtonClicked = (UIButton,addSate: Bool) -> ()
    
    var itemSpecificationButtonClicked: ShopListItemSpecificationButtonClicked?
    var itemAddOrMinusButtonClicked: ShopListItemAddOrMinusButtonClicked?
    

    @IBOutlet weak var imgVIew: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var memo: UILabel!
    
    @IBOutlet weak var starView: StarsView!
    
    @IBOutlet weak var soldCopies: UILabel!
    
    @IBOutlet weak var currentPrice: UILabel!
    
    @IBOutlet weak var oldPrice: UILabel!
    
    @IBOutlet weak var addButtonView: ShopItemAddButtonView!
    
    var selectedView: SpecificationSelectedView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addButtonView.specificationBtnClicked = {
            [unowned self] (sender: UIButton) in
            
                self.itemSpecificationButtonClicked?(sender)
        }
        
        addButtonView.addBtnClicked = {
            (sender: UIButton, add: Bool) in
            self.itemAddOrMinusButtonClicked?(sender, addSate: add)
        }
    }

    func setShoplistItem(item: ShoplistItem) {
        
        imgVIew.image = UIImage(named: item.img)
        title.text = item.name
        memo.text = item.tips
        starView.setStars(item.rateScore)
        soldCopies.text = "月售\(item.monthSoldCopies)份"
        currentPrice.text = "\(item.price)"
        oldPrice.text = "\(item.oldPrice)"
        
        if item.specification.count == 0 {
            addButtonView.isSpecificationButtonShow = false
        } else {
            addButtonView.isSpecificationButtonShow = true
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

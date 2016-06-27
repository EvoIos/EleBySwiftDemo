//
//  TakeawayShopLIstCell.swift
//  ElmDemo
//
//  Created by zhenglanchun on 16/5/31.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

protocol TakeawayShopLIstCellDelegate {
    func clickExpandBtn(id :TakeawayShopLIstCell)
}

class TakeawayShopLIstCell: UITableViewCell {

    //MARK: - IB
    @IBOutlet weak var shopImg: UIImageView!
    @IBOutlet weak var shopName: UILabel!
    
    @IBOutlet weak var shippingCosts: UILabel!
    
    @IBOutlet weak var shippingCostsTipsLab: UILabel!
    
    @IBOutlet weak var shippingSetupPriceLab: UILabel!
    
    @IBOutlet weak var timerAndDistanceLab: UILabel!
    
    @IBOutlet weak var shippingDoingsLab: UILabel!
    
    @IBOutlet weak var topSeperatorViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var expandViewHighConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var expandingContainerView: UIView!
    
    @IBOutlet weak var expandDetailsView: UIView!
    
    @IBOutlet weak var ratingView: StarsView!
    
    
    //付、票、保、蜂鸟专送 View
    @IBOutlet weak var attributesView: UIView!
    //初始值108
    @IBOutlet weak var attributesWidthConstraint: NSLayoutConstraint!
    //距离顶端的距离，当cell是第一个时，设定为0，否则为9
    @IBOutlet weak var separtorLineViewToTopConstaint: NSLayoutConstraint!
    
    @IBOutlet weak var btnSelectStateImgView: UIImageView!
    
    var delegate: TakeawayShopLIstCellDelegate?
    
    var withDetails: Bool?
    
    //MARK: -
    var firstCell: Bool? {
        didSet {
            print("\(firstCell)")
            if firstCell == true {
                topSeperatorViewLeadingConstraint.constant = 0
                separtorLineViewToTopConstaint.constant = 0
            } else {
                topSeperatorViewLeadingConstraint.constant = 15
                separtorLineViewToTopConstaint.constant = 9
            }
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shopImg.layer.cornerRadius = 10
        btnSelectStateImgView.image = UIImage(named: "down")
    }
    
    //MARK: - 设定Cell
    func setModel(shopList: TakeawayHomeShoplist) {
        shopImg.image = UIImage(named: shopList.ShopInfo.shopImg)
        shopName.text = shopList.ShopInfo.shopName
        shippingCosts.text = "￥\(shopList.ShopInfo.shippingCosts)"
        
        if shopList.ShopInfo.shippingCosts == -1  {
            shippingCosts.hidden = true
            shippingCostsTipsLab.text = "免费配送"
        } else {
            shippingCosts.hidden = false
            shippingCostsTipsLab.text = "配送费"
        }
        
        ratingView.setStars(shopList.ShopInfo.shopRatings)
        
        shippingSetupPriceLab.text = shopList.ShopInfo.shippingGetPrice
        
        timerAndDistanceLab.text = shopList.ShopInfo.develiyTime + "分钟/" + shopList.ShopInfo.develiyDistance + "米"
        
        if shopList.ShopInfo.selfAttributes.count != 0 {
            if attributesView.subviews.count > 0 {
                for attributesViewSubView in attributesView.subviews {
                    attributesViewSubView.removeFromSuperview()
                }

            }
            
            var lastLabelLocation: CGFloat = 0
            for i in 0..<shopList.ShopInfo.selfAttributes.count {
                let attributesLabel = UILabel(frame: CGRectMake(0,0,1,1))
                attributesLabel.setLabelBGColorWithTitle(shopList.ShopInfo.selfAttributes[i].attributes)
                attributesLabel.frame = CGRectMake( 3 + lastLabelLocation, 3, attributesLabel.frame.width + 2, 20-6)
                attributesView.addSubview(attributesLabel)
                
                lastLabelLocation = attributesLabel.frame.origin.x + attributesLabel.frame.size.width + 3 + 2
                
            }
            attributesWidthConstraint.constant = lastLabelLocation
            
        }
        
        if withDetails == true {
            updateUI(true)
        } else {
            updateUI(false)
        }
    }
    //MARK: 设定cell扩展属性
    func setExpandingModel(expandingAttributes: [TakeawayHomeExtendedattributes]) {
        if expandingAttributes.count == 0 {
            return
        }
        
        if expandDetailsView.subviews.count > 0 {
            for expandSubView in expandDetailsView.subviews {
                expandSubView.removeFromSuperview()
            }
        }
        
        for  i in 0..<expandingAttributes.count  {
            let item = expandingAttributes[i] 
            let view = SpecialFontView(frame: CGRectMake(0, CGFloat(i * 21), expandingContainerView.frame.size.width, 21))
            view.setViewDetails(specialLabText: item.extendedLabel, detailLabText: item.extendedDetails)
            expandDetailsView.addSubview(view)
        }
        
        shippingDoingsLab.text = "\(expandingAttributes.count)个活动"
        
        //每个扩展块高21
        let expandingHigh = expandingAttributes.count * 21
        if expandingHigh > 42 {
            expandViewHighConstraint.constant = CGFloat(expandingHigh)
        }
        layoutIfNeeded()
    
    }
    
    
    @IBAction func tapExpandBtn(sender: UIButton) {
        self.delegate?.clickExpandBtn(self)

    }
 
    func updateUI(selected: Bool) {
        if selected == true {
            btnSelectStateImgView.image = UIImage(named: "up")
        } else {
            btnSelectStateImgView.image = UIImage(named: "down")
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

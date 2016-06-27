//
//  TakeawayClassificationCell.swift
//  ElmDemo
//
//  Created by z on 16/5/30.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

protocol TakeawayClassificationCellDelegate {
    func shopCategoryItemSelected(currentTag: Int)
}


class TakeawayClassificationCell: UITableViewCell, ClassifiedItemViewDelegate {

    @IBOutlet weak var circleLoopView: LCCircleLoopView!
    
    var delegate: TakeawayClassificationCellDelegate?
    
    @IBOutlet var shopCategoryItems: [ClassifiedItemView]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.01 * Double(NSEC_PER_SEC)))
        
        for item in shopCategoryItems {
            item.delegate = self
        }
        
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.circleLoopView.setImgNames(imgNamesArray: ["lunbo1", "lunbo2", "lunbo3","lunbo4","lunbo5","lunbo6","lunbo7" ])
        }
    }
    
    //MARK: - ClassifiedItemViewDelegate
    func clickedButton(currentTag: Int) {
        
        self.delegate?.shopCategoryItemSelected(currentTag)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  GlobalExtension.swift
//  ElmDemo
//
//  Created by zhenglanchun on 16/6/2.
//  Copyright © 2016年 LC. All rights reserved.
//

import Foundation

extension UILabel {
    func setLabelBGColorWithTitle(title: String) {
        self.clipsToBounds = true
        self.layer.cornerRadius = 3
        self.text = title
        self.textAlignment = .Center
        
        if title.hasPrefix("蜂鸟专送") {
            self.textColor = UIColor.whiteColor()
            self.backgroundColor = develiyBGColor
            
            
        } else {
            if title.hasPrefix("付") {
                self.textColor = SpecialLabBGColor
            }
            if title.hasPrefix("票") {
                self.textColor =  firstLabBGColor
            }
            if title.hasPrefix("保") {
                self.textColor =  giftLabBGColor
            }
            
            self.layer.borderWidth = 1
            self.layer.borderColor = self.textColor.CGColor
        }
    
        self.font = UIFont.systemFontOfSize(11)
        self.sizeToFit()
    }
}

extension UIButton {
    func setBorderColor(defaultColor defaultColor: UIColor, selectedColor: UIColor) {
        if self.selected == false {
            self.layer.borderColor = defaultColor.CGColor
        } else {
            self.layer.borderColor = selectedColor.CGColor
        }
    }
    
    
    func findObjectIndexOfArray(object: NSInteger, array: [NSInteger]) -> NSInteger? {
        if array.contains(object) {
            for i in 0..<array.count {
                if array[i] == object {
                    return i
                }
            }
            return nil
        } else {
            return nil
        }
    }
}

extension UIView {
    func setSize(size: CGSize) {
        var  frame = self.frame
        frame.size = size
        self.frame = frame
    }
}

extension UIViewController {
    func setleftBarButtonItem(imgName: String) {
        let leftButton = UIButton()
        leftButton.setImage(UIImage(named: imgName), forState: .Normal)
        leftButton.setSize((leftButton.currentImage?.size)!)
        leftButton.addTarget(self, action: #selector(leftButtonClicked), forControlEvents: .TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    //MARK: - navigation left button clicked
    func leftButtonClicked() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: - set right navigationbar right item in controller
    func setRightBarButtonItem(imgName: String, rightBtnClicked: Selector) {
        let rightButton = UIButton()
        rightButton.setImage(UIImage(named: imgName), forState: .Normal)
        rightButton.setSize((rightButton.currentImage?.size)!)
        rightButton.addTarget(self, action: rightBtnClicked, forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    
    
    //MARK: - set navigation right item in tabbarcontroller
    func setRightBarButtonItemInTabBarController(name: String, rightBtnClicked: Selector) {
        let rightButton = UIButton(frame: CGRectMake(0,0,40,30))
        rightButton.setTitle(name, forState: .Normal)
        rightButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        rightButton.titleLabel?.textColor = UIColor.whiteColor()
        rightButton.backgroundColor = UIColor.clearColor()
        
        rightButton.addTarget(self, action:rightBtnClicked, forControlEvents: .TouchUpInside)
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
}

//
//  ShopListView.swift
//  LCShopListDemo
//
//  Created by z on 16/6/21.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit
@objc protocol ShopListViewDelegate {
    func lc_tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    func lc_tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    func lc_tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
}

let SHOPLISTVIEWADDBUTTONNOTIFICATIONNAME = "ShopListViewAddButtonNotificationName"

class ShopListView: UIView, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    let TITLESELECTEDCOLOR = UIColor.blueColor()
    let BGCOLOR = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1)
    
    var tableView: UITableView!
    weak var delegate: ShopListViewDelegate?
    
    func currentHigh() -> CGFloat {
        
        return getCurrentHigh( leftMenuNames.count )
    }
    
    var view: UIView!
    var scrollView: UIScrollView!
    
    var leftMenuButtons: Array<UIButton>!
    var leftMenuNames: Array<String>!
    var groupItems: Array<Int>!
    var allSectionHeightDatas: Array<CGFloat>!
    var sectionHeaderHeight: CGFloat!
//    var rowHeight: CGFloat!
    //MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        initData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        initData()
    }

    func  setupUI() {
        view = UIView()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
        
        scrollView = UIScrollView(frame: CGRectMake(0,0,view.frame.size.width * 0.2, view.frame.size.height))
        scrollView.pagingEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = scrollView.frame.size
        scrollView.delegate = self
        scrollView.backgroundColor = BGCOLOR
        view.addSubview(scrollView)
    
        tableView = UITableView(frame: CGRectMake(view.frame.size.width * 0.2,0,view.frame.size.width * 0.8, view.frame.size.height), style:.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.backgroundColor = UIColor.lightGrayColor()
    }
    
    func initData() {
        leftMenuButtons = []
        leftMenuNames = []
        allSectionHeightDatas = []
        groupItems = []
    }
    
    //MARK: public set left menu and tableView
    func setLeftMenu(menuData: Array<String>, withGroupItemCount groupItemsArray: Array<Int>) {
        leftMenuNames = menuData
        groupItems = groupItemsArray
        
        weak var weakSelf = self
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            //update frame
            weakSelf!.scrollView.frame = CGRectMake(0,0,weakSelf!.view.frame.size.width * 0.2, weakSelf!.view.frame.size.height)
            weakSelf!.scrollView.contentSize = weakSelf!.scrollView.frame.size
            weakSelf!.tableView.frame = CGRectMake(weakSelf!.view.frame.size.width * 0.2,0,weakSelf!.view.frame.size.width * 0.8, weakSelf!.view.frame.size.height)
            
            for i in 0..<menuData.count {
                weakSelf!.scrollView.contentSize = CGSizeMake(weakSelf!.scrollView.frame.size.width, (CGFloat)(menuData.count * 40));
               let tmpBtn = UIButton(frame: CGRectMake(0, 40 * CGFloat(i), weakSelf!.scrollView.frame.size.width, 40))
                tmpBtn.setTitle(menuData[i], forState: .Normal)
                tmpBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                tmpBtn.setTitleColor(weakSelf!.TITLESELECTEDCOLOR, forState: .Selected)
                
                tmpBtn.titleLabel?.font = UIFont.systemFontOfSize(14.0)
                tmpBtn.titleLabel?.numberOfLines = 2;
                tmpBtn.titleLabel?.textAlignment = .Center
                tmpBtn.tag = i + 100
                tmpBtn.addTarget(weakSelf, action: #selector(weakSelf!.btnClicked(_:)), forControlEvents: .TouchUpInside)
                
                if i == 0   {
                    tmpBtn.selected = true
                }
                weakSelf!.leftMenuButtons.append(tmpBtn)
                weakSelf!.scrollView.addSubview(tmpBtn)
                
//                let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//                let rect1 = weakSelf!.tableView.rectForRowAtIndexPath(indexPath)
//                weakSelf!.rowHeight = rect1.size.height;
            }
            weakSelf!.tableView.reloadData()
        }
        
        
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            for i in 0..<weakSelf!.leftMenuButtons.count {
                let frame = weakSelf!.tableView.rectForSection(i)
                let sectionH = frame.origin.y + frame.size.height;
                weakSelf!.allSectionHeightDatas.append(sectionH)
            }
        }
        
    }
    //MARK: menu button clicked
    func btnClicked(sender: UIButton) {
        let index = sender.tag - 100
        print(index)
        let high = getCurrentHigh(index)
        print("high: \(high)")
        tableView.setContentOffset(CGPointMake(0, high), animated: true)
        NSNotificationCenter.defaultCenter().postNotificationName(SHOPLISTVIEWADDBUTTONNOTIFICATIONNAME, object: nil, userInfo: nil)
    }
    
    func getCurrentHigh(index: Int) -> CGFloat{
        if index == 0 {
            return 0
        }
        var high:CGFloat = 0
        for i in 0..<index {
            let rect = tableView.rectForSection(i)
            high += rect.size.height
        }
       
        return high
    }
    
    //MARK: scrollView delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == tableView {
            let locationY = scrollView.contentOffset.y
            let index = getSectionIndexFromLocation(locationY)
            
            for i in 0..<leftMenuButtons.count {
                let tmpBtn = leftMenuButtons[i]
                tmpBtn.selected = false
                tmpBtn.backgroundColor = BGCOLOR
            }
            
            if leftMenuButtons.count != 0 {
                let tmpBtn = leftMenuButtons[index]
                tmpBtn.selected = true
                tmpBtn.backgroundColor = UIColor.whiteColor()
            }
        }
    }
    
    func getSectionIndexFromLocation(locationY: CGFloat) -> Int{
        for h in allSectionHeightDatas {
            if locationY < h {
                return allSectionHeightDatas.indexOf(h)!
            }
        }
        return 0
    }
    
    //MARK: tableView delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if leftMenuButtons.count == 0 {
            return 0
        }
        return leftMenuButtons.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if groupItems.count == 0 {
            return 0
        }
        return groupItems[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       return (delegate?.lc_tableView(tableView, cellForRowAtIndexPath: indexPath))!
    
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if leftMenuNames.count == 0 {
            return ""
        }
        return leftMenuNames[section]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.lc_tableView(tableView, didSelectRowAtIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (delegate?.lc_tableView(tableView, heightForRowAtIndexPath: indexPath))!
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = SEPARATOR_COLOR
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    
}

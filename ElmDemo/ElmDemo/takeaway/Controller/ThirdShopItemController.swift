//
//  ThirdShopItemController.swift
//  ElmDemo
//
//  Created by zhenglanchun on 16/6/19.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class ThirdShopItemController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var cellHighDic = [String: CGFloat]()
    var heigh: CGFloat {
        get {
            var tmpHeigh: CGFloat = 0
            for (_,value) in cellHighDic {
                tmpHeigh += value
            }
            return tmpHeigh
        }
    }
    var contentOffset: CGPoint {
        get {
            return tableView.contentOffset
        }
        set(contentOffset) {
            tableView.contentOffset = contentOffset
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    
    func setupTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .Grouped)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollEnabled = false
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.registerNib(UINib(nibName: "ShopSelfDetailCell", bundle: nil), forCellReuseIdentifier: "ShopSelfDetailCell")
        tableView.registerNib(UINib(nibName: "ShopSelfContentCell", bundle: nil), forCellReuseIdentifier: "ShopSelfContentCell")
    }
    
   
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ShopSelfDetailCell") as? ShopSelfDetailCell
            return cell!
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ShopSelfContentCell") as? ShopSelfContentCell
            if  indexPath.section == 1 {
                cell!.showContainerView = false
            } else {
                cell!.showContainerView = true
            }
            
            return cell!
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            cellHighDic["\(indexPath.row)"] = 126
            return 126
        } else {
            cellHighDic["\(indexPath.row)"] = 184
            return 184
            }
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    
}

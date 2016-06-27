//
//  SecondShopItemController.swift
//  ElmDemo
//
//  Created by zhenglanchun on 16/6/19.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class SecondShopItemController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
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

    
    var cellHighDic = [String: CGFloat]()
    
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
        
        tableView.registerNib(UINib(nibName: "EvaluationHeadCell", bundle: nil), forCellReuseIdentifier: "EvaluationHeadCell")
        //EvaluationContentCell
        tableView.registerNib(UINib(nibName: "EvaluationContentCell", bundle: nil), forCellReuseIdentifier: "EvaluationContentCell")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if  indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("EvaluationHeadCell") as? EvaluationHeadCell
            cell?.selectionStyle = .None
            
            return cell!
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("EvaluationContentCell") as? EvaluationContentCell
            cell!.memo.text = "\(indexPath.row)"
            cell?.selectionStyle = .None
            return cell!
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            cellHighDic["section\(indexPath.row)"] = 100
            return 100
        } else {
            cellHighDic["\(indexPath.row)"] = 90
            return 90;
        }
        
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0 {
            cellHighDic["footer\(section)"] = 20
            return 20
        } else {
            return 0
        }
        
    }
    

    
    
}


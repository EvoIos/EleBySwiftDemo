//
//  OrderController.swift
//  ElmDemo
//
//  Created by zhenglanchun on 16/5/29.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class OrderController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        automaticallyAdjustsScrollViewInsets = true
        view.backgroundColor = UIColor.whiteColor()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setRightBarButtonItemInTabBarController("早餐", rightBtnClicked: #selector(rightBtnClicked))
        tabBarController?.navigationItem.title = "订单"
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.navigationItem.rightBarButtonItem = nil
        
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .Grouped)
        view.addSubview(tableView!)
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        tableView?.registerNib(UINib.init(nibName: "OrderListCell", bundle: nil), forCellReuseIdentifier: "OrderListCell")
    }
    
    func rightBtnClicked() {
        print("here")
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OrderListCell") as? OrderListCell
        cell?.selectionStyle = .None
        cell?.orderButtonClicked = {
            let detailVC = OrderDetailController()
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        cell?.shopButtonClicked = {
            let shopItemListVC = TakeawayShopItemListController()
            self.navigationController?.pushViewController(shopItemListVC, animated: true)
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 208
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

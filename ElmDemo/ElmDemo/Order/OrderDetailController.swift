//
//  OrderDetailController.swift
//  ElmDemo
//
//  Created by z on 16/6/25.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class OrderDetailController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单详情"
        setleftBarButtonItem("向左箭头")
        setRightBarButtonItem("电话", rightBtnClicked: #selector(rightButtonAction))
        setupTableView()
        
    }
    
    func setupTableView() {
         tableView?.registerNib(UINib.init(nibName: "OrderDetailHeadCell", bundle: nil), forCellReuseIdentifier: "OrderDetailHeadCell")
        
        tableView?.registerNib(UINib.init(nibName: "OrderDetailAdsCell", bundle: nil), forCellReuseIdentifier: "OrderDetailAdsCell")
        
        tableView?.registerNib(UINib.init(nibName: "OrderDetailShopInfoCell", bundle: nil), forCellReuseIdentifier: "OrderDetailShopInfoCell")
        
        
        tableView?.registerNib(UINib.init(nibName: "OrderDetailDeliveryInfoCell", bundle: nil), forCellReuseIdentifier: "OrderDetailDeliveryInfoCell")
        
        tableView?.registerNib(UINib.init(nibName: "OrderDetailContentCell", bundle: nil), forCellReuseIdentifier: "OrderDetailContentCell")
        
        
    }
    
    func rightButtonAction() {
        print("rightButtonAction")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell?
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("OrderDetailHeadCell") as? OrderDetailHeadCell
            break
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("OrderDetailAdsCell") as? OrderDetailAdsCell
            break
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("OrderDetailShopInfoCell") as? OrderDetailShopInfoCell
            break
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("OrderDetailDeliveryInfoCell") as? OrderDetailDeliveryInfoCell
            break
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier("OrderDetailContentCell") as? OrderDetailContentCell
            break
        default:
            cell = nil
            break
        }
        cell?.selectionStyle = .None
        return cell!
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 133
        case 1:
            return 95
        case 2:
            return 250
        case 3:
            return 80
        case 4:
            return 244
        default:
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

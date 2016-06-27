//
//  TakeawayViewController.swift
//  ElmDemo
//
//  Created by zhenglanchun on 16/5/29.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit


class TakeawayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TakeawayShopLIstCellDelegate, TakeawayClassificationCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var lastY: CGFloat = 0.0
    var model: TakeawayHomeModel!
    var selectIndexInfo: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.contentInset = UIEdgeInsetsMake(44 - 8, 0, 0, 0)
        searchBar.barTintColor = NAVBG_COLOR
        //load data
        let filePath = NSBundle.mainBundle().pathForResource("TakeawayHome", ofType: "json")
        let contentData = NSFileManager.defaultManager().contentsAtPath(filePath!)
        let content = NSString(data: contentData!, encoding: NSUTF8StringEncoding) as? String
        model = TakeawayHomeModel.mj_objectWithKeyValues(content)
        print(model)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupTitleView()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.navigationItem.titleView = nil
    }
    
    func leftClicked()  {
        print("left")
            }
    
    func titleBtnClick() {
        print("titleBtn clicked")
    }
    
    func setupTitleView() {
        let titleViewBtn = UIButton(frame: CGRectMake(0, 0, 50, 25))
        
        titleViewBtn.setTitle("农光里", forState: .Normal)
        titleViewBtn.setImage(UIImage(named: "定位"), forState: .Normal)
        titleViewBtn.setTitleColor(NAVIGATIONTITLEH_COLOR, forState: .Highlighted)
        titleViewBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        titleViewBtn.addTarget(self, action: #selector(TakeawayViewController.titleBtnClick), forControlEvents: .TouchUpInside)
        tabBarController?.navigationItem.titleView = titleViewBtn

    }
    
    //MARK: - search button clicked
    @IBAction func searchBtnClick(sender: UIButton) {
        let searchVC = TakeawaySearchController.init()
        self.navigationController!.pushViewController(searchVC, animated: true)
    }
    //MARK: - TakeawayClassificationCellDelegate
    func shopCategoryItemSelected(currentTag: Int) {
        print("selectedItem: \(currentTag)")
        
        switch currentTag {
        case 100:
            let filterController = ShopFilterController()
            filterController.title = "美食"
            navigationController?.pushViewController(filterController, animated: true)
            break
        case 101:
            let filterController = ShopFilterController()
            filterController.title = "土豪推荐"
            navigationController?.pushViewController(filterController, animated: true)
            break
        case 102:
            let webVC = CommonWebController()
            navigationController?.pushViewController(webVC, animated: true)
            webVC.title = "预定早餐"
            break
            
        case 103:
            let filterController = ShopFilterController()
            filterController.title = "蜂鸟专送"
            navigationController?.pushViewController(filterController, animated: true)
            break
            
        case 104:
            let filterController = ShopFilterController()
            filterController.title = "超市便利店"
            navigationController?.pushViewController(filterController, animated: true)
            break
            
        case 105:
            let filterController = ShopFilterController()
            filterController.title = "甜品饮食"
            navigationController?.pushViewController(filterController, animated: true)
            break
            
        case 106:
            let filterController = ShopFilterController()
            filterController.title = "果蔬生鲜"
            navigationController?.pushViewController(filterController, animated: true)
            break
            
        case 107:
            let filterController = ShopFilterController()
            filterController.title = "鲜花蛋糕"
            navigationController?.pushViewController(filterController, animated: true)
            break
        default:break
        }
    }
    

    
    //MARK: - TakeawayShopListCellDelegate
    func clickExpandBtn(id: TakeawayShopLIstCell) {
        let indexPathRow = id.tag - 100
        
        if model.ShopList[indexPathRow].extendedAttributes.count >= 2 {
            
            if selectIndexInfo.contains(indexPathRow) == true {
                let index = selectIndexInfo.indexOf(indexPathRow)
                selectIndexInfo.removeAtIndex(index!)
            } else {
                selectIndexInfo.append(indexPathRow)
            }
            let indexPath = NSIndexPath(forRow: indexPathRow, inSection: 2)
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        }

    }
    
    //MARK: - tableView delegate didSelectRowAtIndexPath
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = TakeawayShopItemListController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - tableView dataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        }
        return model.ShopList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCellWithIdentifier("TakeawayClassificationCell") as? TakeawayClassificationCell
            if cell == nil {
               
                let bundle = NSBundle(forClass: self.dynamicType)
                let nib = UINib(nibName: "TakeawayClassificationCell", bundle: bundle)
                cell = nib.instantiateWithOwner(nil, options: nil)[0] as? TakeawayClassificationCell
                cell!.selectionStyle = .None
            }
            cell!.delegate = self
            
            return cell!
        } else if indexPath.section == 1 {
            var cell = tableView.dequeueReusableCellWithIdentifier("TakeawaySalesCell")
            if cell == nil {
                let bundle = NSBundle(forClass: self.dynamicType)
                let nib = UINib(nibName: "TakeawaySalesCell", bundle: bundle)
                cell = nib.instantiateWithOwner(nil, options: nil)[0] as! TakeawaySalesCell
                cell!.selectionStyle = .None
            }
            return cell!
        } else {
            var cell: TakeawayShopLIstCell! = tableView.dequeueReusableCellWithIdentifier("TakeawayShopLIstCell") as? TakeawayShopLIstCell
            if cell == nil {
                let bundle = NSBundle(forClass: self.dynamicType)
                let nib = UINib(nibName: "TakeawayShopLIstCell", bundle: bundle)
                cell = nib.instantiateWithOwner(nil, options: nil)[0] as! TakeawayShopLIstCell
                cell.selectionStyle = .None
                
            }
            if indexPath.row == 0 {
                cell.firstCell = true
            } else {
                cell.firstCell = false
            }
            cell.tag = indexPath.row + 100
            cell.delegate = self
            
            if selectIndexInfo.count > 0 {
                if selectIndexInfo.contains(indexPath.row) {
                    cell.withDetails = true
                } else {
                    cell.withDetails = false
                }
            }
            
            cell.setModel(model.ShopList[indexPath.row])
            cell.setExpandingModel(model.ShopList[indexPath.row].extendedAttributes)
            
            
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 274
        } else if indexPath.section == 1 {
            return 189
        } else {
            
            var high = model.ShopList[indexPath.row].extendedAttributes.count * 21 + 90
            if high > 21 * 2 + 90  {
                if selectIndexInfo.contains(indexPath.row) != true {
                    high =  21 * 2 + 90
                }
                if indexPath.row == 0 {
                    high = high - 9
                }
                return CGFloat(high)
            }
            if indexPath.row == 0 {
                high = high - 9
            }
            return CGFloat(high)
            
        }
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    //MARK: - UIScrollView delegate
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if scrollView == tableView {
            
            lastY = scrollView.contentOffset.y
        }
        
    }
    
    //MARK
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == tableView {
            if scrollView.contentOffset.y < -100 {
                topConstraint.constant = 64 - 8
                return
            } else if scrollView.contentOffset.y >= -64 {
                topConstraint.constant = 20
                return
            }
            
            //- 108 - (-44) = -64
            // delt = last = -108
            
            //topConstraint -64 -> -20
            let y = scrollView.contentOffset.y
            //
            let delt =  y - lastY
            print("delt: \(delt)")
            
            if  delt < 44 - 8 {
                topConstraint.constant = 64 - 8  - delt
            } else {
                topConstraint.constant = 20
            }
            
            if topConstraint.constant >= 64 - 8 {
                topConstraint.constant = 64 - 8
            }
            
            self.view.setNeedsLayout()
            
            
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}

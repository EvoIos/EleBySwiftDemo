//
//  ShopFilterController.swift
//  ElmDemo
//
//  Created by zhenglanchun on 16/6/4.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit


class ShopFilterController: UIViewController, LCFileterButtonDelegate, ShopFilterListViewDelegate, ShopFilterSortViewDelegate, ShopFilterListBtnViewDelegate, UITableViewDelegate, UITableViewDataSource, TakeawayShopLIstCellDelegate {
    
    var filterView: ShopFilterListView?
    var filterSortView: ShopFilterSortView!
    var filterListView: ShopFilterListBtnView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var segmentBtns: [LCFileterButton]!
    
    var model: TakeawayFilterModel!
    var datas: TakeawayHomeModel!
    var tmpLeftBtn: UIButton?
    var selectIndexInfo: [Int] = []
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        for tmpBtn in segmentBtns {
            tmpBtn.delegate = self
        }
        //navigationItem leftBarButtonItem
        setleftBarButtonItem("向左箭头")
        
        
        
        //左
        filterView = ShopFilterListView(frame: CGRectMake(0, 64+44+1, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - 64 - 44 - 1 - 100))
        filterView?.hidden = true
        filterView!.delegate = self
        view.addSubview(filterView!)
        
        let filePath = NSBundle.mainBundle().pathForResource("TakeawayFilter", ofType: "json")
        let contentData = NSFileManager.defaultManager().contentsAtPath(filePath!)
        let content = NSString(data: contentData!, encoding: NSUTF8StringEncoding) as? String
        model = TakeawayFilterModel.mj_objectWithKeyValues(content)
        filterView?.setFilterViewModel(model)
        
        //中
        filterSortView = ShopFilterSortView(frame: CGRectMake(0, 64+44+1, UIScreen.mainScreen().bounds.size.width, 44 * 6))
        filterSortView.delegate = self
        filterSortView.hidden = true
        view.addSubview(filterSortView)
        
        //右
        filterListView = ShopFilterListBtnView(frame: CGRectMake(0, 64+44+1, UIScreen.mainScreen().bounds.size.width, 340))
        filterListView.delegate = self
        filterListView.hidden = true
        view.addSubview(filterListView)
        
        let dataFilePath = NSBundle.mainBundle().pathForResource("TakeawayHome", ofType: "json")
        let data = NSFileManager.defaultManager().contentsAtPath(dataFilePath!)
        let contentStr = NSString(data: data!, encoding: NSUTF8StringEncoding) as? String
        datas = TakeawayHomeModel.mj_objectWithKeyValues(contentStr)
        print(datas)
    
    }
    
    //MARK: - filter view delegate
    
    func didSelectedShopItem(shopInfo: Categorydetails) {
        filterView?.hidden = true
        
        for item  in segmentBtns {
            if item.tag == 100 {
                tmpLeftBtn?.selected = false
                item.updateUI(tmpLeftBtn!)
                break
            }
        }
        
        print("选中商品： \(shopInfo.shopItemName)")
    }
    
    
    //MARK: ShopFilterListBtnViewDelegate
    func clickedFilterListBtn(selectedBtnInfo: [NSInteger]) {
        filterListView.hidden = true
        
        for item  in segmentBtns {
            if item.tag == 102 {
                tmpLeftBtn?.selected = false
                item.updateUI(tmpLeftBtn!)
                break
            }
        }
        
        print("筛选方式：\(selectedBtnInfo)")
    }
    
    //MARK: ShopFilterSortViewDelegate
    func didSelectSortItem(currentIndex: Int) {
        
        filterSortView.hidden = true
        
        for item  in segmentBtns {
            if item.tag == 101 {
                tmpLeftBtn?.selected = false
                item.updateUI(tmpLeftBtn!)
                break
            }
        }
        
        print("排序方式：\(currentIndex)")
    }
    
    //MARK: LCFileterButtonDelegate 
    func tapButtonWithCurrentTag(currentBtn: UIButton, currentTag: Int) {
        
        if currentBtn.selected == true {
            showFilterListView(currentTag)
        } else {
            hideFilterListView(currentTag)
        }
        
        if tmpLeftBtn == currentBtn {
            //hideFilterListView(currentTag)
            return
        }
        
        if tmpLeftBtn != nil {
            tmpLeftBtn?.selected = false
            for item  in segmentBtns {
                if item.tag == tmpLeftBtn?.tag
                {
                    item.updateUI(tmpLeftBtn!)
                    break
                }
            }
        }
        tmpLeftBtn = currentBtn
        tmpLeftBtn?.tag = currentTag
    }
    
    //MARK: - TakeawayShopListCellDelegate
    func clickExpandBtn(id: TakeawayShopLIstCell) {
        let indexPathRow = id.tag - 100
        
        if datas.ShopList[indexPathRow].extendedAttributes.count >= 2 {
            
            if selectIndexInfo.contains(indexPathRow) == true {
                let index = selectIndexInfo.indexOf(indexPathRow)
                selectIndexInfo.removeAtIndex(index!)
                
            } else {
                selectIndexInfo.append(indexPathRow)
                
            }
            let indexPath = NSIndexPath(forRow: indexPathRow, inSection: 0)
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        }
        
    }
    
    //MARK: - uitableView delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.ShopList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
        cell.setModel(datas.ShopList[indexPath.row])
        cell.setExpandingModel(datas.ShopList[indexPath.row].extendedAttributes)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var high = datas.ShopList[indexPath.row].extendedAttributes.count * 21 + 90
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
    
    
    
    //MARK: - private help func
    func showFilterListView(viewTag: Int ) {
        if viewTag == 100 {
            filterView?.hidden = false
            filterSortView.hidden = true
            filterListView.hidden = true
        } else if viewTag == 101 {
            filterView?.hidden = true
            filterSortView.hidden = false
            filterListView.hidden = true
        } else {
            filterView?.hidden = true
            filterSortView.hidden = true
            filterListView.hidden = false
        }
    }
    
    func hideFilterListView(viewTag: Int ) {
        //hide lastView
        if viewTag == 100 {
            filterView?.hidden = true
        } else if viewTag == 101 {
            filterSortView.hidden = true
        } else {
            filterListView.hidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

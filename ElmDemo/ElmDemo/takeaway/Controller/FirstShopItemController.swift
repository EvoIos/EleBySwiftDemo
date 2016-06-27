//
//  FirstShopItemController.swift
//  ElmDemo
//
//  Created by zhenglanchun on 16/6/19.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

let FIRSTSHOPITEMNOTIFICATION = "firstShopItemAddOrCancelNotiName"
class FirstShopItemController: UIViewController, ShopListViewDelegate {

    var listView: ShopListView!
    
    var heigh: CGFloat {
        get {
            print("max high: \(listView.currentHigh())")
           return listView.currentHigh()
        }
    }
    var contentOffset: CGPoint {
        get {
            return listView.tableView.contentOffset
        }
        set(contentOffset) {
            listView.tableView.contentOffset = contentOffset
        }
    }
    
    var model: ShopListModel!
    var leftMenuNames: [String] = []
    var groupItemCounts: [Int] = []
    
    var targetView: UIView?
    //sepcificationView
    var specificationView: SpecificationSelectedView?
    
    var boundsYOfListView: CGFloat = 204
    
    //count 
    var count: NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //add observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(boundsOfSuperViewChanged), name: BOUNDSCHANGEDNOTIFICATIONNAME, object: nil)
        
        loadData()
        setupUI()
        specificationView = SpecificationSelectedView(frame: view.bounds)
        specificationView?.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        specificationView?.alpha = 1
        specificationView?.hidden = true
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            [unowned self] in
            self.navigationController?.view.addSubview(self.specificationView!)
        }
        
        specificationView?.cancelButtonClicked = {
            [unowned self] (sender: UIButton)in
            self.specificationView?.hidden = true
            
            
        }
        specificationView?.confirmButtonClicked = {
            (sender: UIButton) in
            self.specificationView?.hidden = true
            self.specificationButtonAnimation(sender)
            
        }
        
    }
    
    func loadData() {
        let filePath = NSBundle.mainBundle().pathForResource("shopListData", ofType: "json")
        let contentData = NSFileManager.defaultManager().contentsAtPath(filePath!)
        let content = NSString(data: contentData!, encoding: NSUTF8StringEncoding) as? String
        model = ShopListModel.mj_objectWithKeyValues(content)
        print(model)
        
        for item in model.data {
            leftMenuNames.append(item.categories)
            groupItemCounts.append(item.shopList.count)
        }
    }
    
    func setupUI() {
        listView = ShopListView(frame: view.bounds)
        listView.delegate = self
        listView.tableView.scrollEnabled = false
        view.addSubview(listView)
        listView.setLeftMenu(leftMenuNames, withGroupItemCount: groupItemCounts)
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            print(self.heigh)
        }
        
    }
    //MARK: - cell button clicked
    func showSpecificationView(sender: UIButton) {
        
        specificationView?.hidden = false
    }
    
    //MARK: - notification observer
    func boundsOfSuperViewChanged(noti: NSNotification) {
        
        let userInof = noti.userInfo!
        let boundsY = userInof["boundsY"] as! CGFloat
        print("boundsY值：\(boundsY)")
        boundsYOfListView = boundsY
    }
    
    //MARK: - animation
    func addOrMinusButtonAnimation(targetButton: UIButton) {
        //放置动画未执行完前再次执行动画
        for tmpView in view.subviews {
            if targetView == tmpView {
                return
            }
        }

        print("\(UIScreen.mainScreen().bounds.size)")
        
        var rect = view.convertRect(CGRectZero, fromView: targetButton)
        rect.size = CGSizeMake(20, 20)
  
        
        targetView = UIView(frame: rect)
        targetView?.backgroundColor = BUTTONBGCOLOR
        view.addSubview(targetView!)
        targetView?.layer.cornerRadius = 10
        
        let startPosition = targetView!.layer.position
        let endPosition = CGPointMake(0 + 23, UIScreen.mainScreen().bounds.size.height -  28  - boundsYOfListView)
        print(endPosition.y)
        let controlPoint = CGPointMake(startPosition.x / 4.0, startPosition.y - 50)
        let keyValueName = "addCurvAnim"
        
        self.addQuadCurveAnimation(self.targetView!, startPosition: startPosition, endPosition: endPosition, controlPoint: controlPoint, keyValueName: keyValueName)
        
    }
    
    func specificationButtonAnimation(targetButton: UIButton) {
        
        
        let rect =  CGRectMake(targetButton.superview!.frame.origin.x + targetButton.frame.origin.x, targetButton.superview!.frame.origin.y , targetButton.frame.size.width, targetButton.frame.size.height)
        
        targetView = UIView(frame: rect)
        targetView?.backgroundColor = BUTTONBGCOLOR
        view.addSubview(targetView!)
        
        let value1 = targetView!.bounds.size.width
        let value2 = 30
        
        let animation = CAKeyframeAnimation(keyPath: "bounds.size.width")
        animation.duration = 0.3
        animation.values = [value1, value2]
        animation.keyTimes = [0.1,0.9]
        animation.setValue("width", forKey: "width")
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        targetView!.layer.addAnimation(animation, forKey: nil)
        
        targetView!.layer.cornerRadius = 15
        
        
        let startPosition = targetView!.layer.position
        let endPosition = CGPointMake(0 + 23, view.frame.size.height - 34)
        let controlPoint = CGPointMake(startPosition.x / 3.0, startPosition.y - 50)
        let keyValueName = "scaleCurvAni"
        let timer = dispatch_time(DISPATCH_TIME_NOW, Int64(0.29 * Double(NSEC_PER_SEC)))
        dispatch_after(timer, dispatch_get_main_queue()) {
            [unowned self] in
            self.addQuadCurveAnimation(self.targetView!, startPosition: startPosition, endPosition: endPosition, controlPoint: controlPoint, keyValueName: keyValueName)
        }
    }
    
    func addQuadCurveAnimation(item: UIView, startPosition: CGPoint, endPosition: CGPoint, controlPoint: CGPoint, keyValueName: String) {
        //add BezierPath
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(startPosition)
        bezierPath.addQuadCurveToPoint(endPosition, controlPoint: controlPoint)
        
        //add CAKeyframeAnimation
        let moveAnim = CAKeyframeAnimation(keyPath: "position")
        moveAnim.path = bezierPath.CGPath;
        moveAnim.removedOnCompletion = false
        moveAnim.delegate = self
        item.layer.addAnimation(moveAnim, forKey: nil)
        
        //add scale animation
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = 1.0
        scaleAnim.toValue = 0.7
        
        //add group animation
        let groupAnim = CAAnimationGroup()
        groupAnim.animations = [moveAnim,scaleAnim]
        groupAnim.setValue(keyValueName, forKey: keyValueName)
        groupAnim.removedOnCompletion = false
        groupAnim.delegate = self
        groupAnim.duration = 1
        item.layer.addAnimation(groupAnim, forKey: "group")
        
        //辅助线
        let shape = CAShapeLayer()
//        shape.path = bezierPath.CGPath
//        shape.fillColor = UIColor.clearColor().CGColor
//        shape.strokeColor = UIColor.orangeColor().CGColor
//        
//        view.layer.addSublayer(shape)
    }
    //MARK: - animation delegate
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        let value = anim.valueForKey("scaleCurvAni") as? String
        let addOrMinusButtonValue = anim.valueForKey("addCurvAnim") as? String
        if  value == "scaleCurvAni" {
            targetView?.removeFromSuperview()
            NSNotificationCenter.defaultCenter().postNotificationName(FIRSTSHOPITEMNOTIFICATION, object: nil, userInfo: ["state": "add"])
        }
        if addOrMinusButtonValue == "addCurvAnim" {
            targetView?.removeFromSuperview()
            NSNotificationCenter.defaultCenter().postNotificationName(FIRSTSHOPITEMNOTIFICATION, object: nil, userInfo: ["state": "add"])
        }
    }
    
    //MARK: - listView delegate
    func lc_tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ShopListItemCell") as? ShopListItemCell
        if cell == nil {
            let bundle = NSBundle(forClass: self.dynamicType)
            let nib = UINib(nibName: "ShopListItemCell", bundle: bundle)
            cell = nib.instantiateWithOwner(nil, options: nil)[0] as? ShopListItemCell
            cell!.selectionStyle = .None
        }
        cell?.setShoplistItem(self.model.data[indexPath.section].shopList[indexPath.row])
        cell?.itemSpecificationButtonClicked = {
            [unowned self] (sender: UIButton)in
            self.showSpecificationView(sender)
        }
        
        cell?.itemAddOrMinusButtonClicked = {
            (sender: UIButton, addState: Bool) in
            if  addState == true {
                self.count += 1
                
                self.addOrMinusButtonAnimation(sender)
                
            } else {
                self.count -= 1
                if self.count < 0 {
                    
                }
                NSNotificationCenter.defaultCenter().postNotificationName(FIRSTSHOPITEMNOTIFICATION, object: nil, userInfo: ["state": "minus"])
            }
            print(self.count)
        }
        
        return cell!
    }
    
    func lc_tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func lc_tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        let detailVC = ShopItemDetailController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

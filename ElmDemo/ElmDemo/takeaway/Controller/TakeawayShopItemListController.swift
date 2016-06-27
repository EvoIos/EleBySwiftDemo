//
//  TakeawayShopItemListController.swift
//  ElmDemo
//
//  Created by zhenglanchun on 16/6/16.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

let DISTIANCETONAVIGATIONBAR:CGFloat = 160.0 - 64.0
let BOUNDSCHANGEDNOTIFICATIONNAME = "ShopItemListBoundsChangedNotificationName"

class TakeawayShopItemListController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate{

    @IBOutlet weak var maskBGImgView: UIImageView!
    @IBOutlet weak var bottomScrollView: UIScrollView!
    @IBOutlet weak var bgContainerView: UIView!
    
    @IBOutlet weak var frontContainerView: UIView!
    
    @IBOutlet weak var adsContainerView: UIView!
    
    @IBOutlet weak var sliderViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sliderView: UIView!
    
    @IBOutlet weak var shopOfSegmentButton: UIButton!
    
    @IBOutlet weak var evaluationButton: UIButton!
    
    @IBOutlet weak var businessButton: UIButton!
    //shopcar
    @IBOutlet weak var shopCarContainerView: UIView!
    
    @IBOutlet weak var badgeLab: UILabel!
    
    var tmpBtn: UIButton?
    
    let width = UIScreen.mainScreen().bounds.size.width
    let bottomScrollViewHigh = UIScreen.mainScreen().bounds.size.height - 64 - 44
    
    var pan: UIPanGestureRecognizer!
    
    //right navigation button
    var rightView: UIView!
    var rightFirstView: UIView!
    var rightSecondView: UIView!
    
    //first second third view
    var firstShopItemVC: FirstShopItemController!
    var secondShopItemVC: SecondShopItemController!
    var thirdShopItemVC: ThirdShopItemController!
    
    //alpha state change value
    let deltY:CGFloat = 40.0
    let deltSecondY:CGFloat = 160.0 - 64 - 40.0
    
    //last position or state
    var lastPointY: CGFloat = 0
    var lastOffset: CGPoint = CGPointZero
    var lastChangedOffset: CGPoint = CGPointZero
    var lastChangedOrigin: CGPoint = CGPointZero
    var velocityDirectionDown: Bool = false
    //last gr location
    var lastGrLocation: CGPoint = CGPointZero
    //last bottomScrollView contentoffset
    var lastBottomScrollViewOffset: CGPoint = CGPointZero
    
    
    //change State
    var currentStateChange:Bool = true
    var locationEndState: NSInteger = 0
    var verticalState: Bool = false
    
    //dynamic animation
    var dynamicItem: LCDynamicItem!
    var animator: UIDynamicAnimator?
    weak var decelerateBehavior: UIDynamicItemBehavior?
    weak var springBehavior: UIAttachmentBehavior?
    
    //count
    var count: NSInteger = 0
    
    //max offset
    func maxOffset() -> CGFloat{
        var tmpHigh: CGFloat!
        
        if  tmpBtn?.tag == 100 {
            tmpHigh = firstShopItemVC.heigh - bottomScrollView.contentSize.height
            if  tmpHigh < 0 {
                tmpHigh = 0
            }
            return tmpHigh
        } else if tmpBtn?.tag == 101 {
            
            tmpHigh = secondShopItemVC.heigh - bottomScrollView.contentSize.height
            if  tmpHigh < 0 {
                tmpHigh = 0
            }
            return tmpHigh
           
        } else {
            tmpHigh = thirdShopItemVC.heigh - bottomScrollView.contentSize.height
            if  tmpHigh < 0 {
                tmpHigh = 1
            }
            return tmpHigh
        }
        
    }
    
    func tableViewOffset() -> CGPoint {
        if  tmpBtn?.tag == 100 {
            return firstShopItemVC.contentOffset
        } else if tmpBtn?.tag == 101 {
            return secondShopItemVC.contentOffset
        } else {
            return thirdShopItemVC.contentOffset
        }
    }
    func setTableViewOffset(offset: CGPoint) {
        
        if  tmpBtn?.tag == 100 {
            firstShopItemVC.contentOffset = offset
        } else if tmpBtn?.tag == 101 {
            secondShopItemVC.contentOffset = offset
        } else {
            thirdShopItemVC.contentOffset = offset
        }
        
    }
    
    
    //MARK: - viewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.tag = 10
        
        setleftBarButtonItem("向左箭头")
        setupRightNavigationBarItem()
        setupBottomScrollView()
        
        segmentButtonClicked(shopOfSegmentButton)
        
        //getsure
        pan = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        pan.delegate = self
        frontContainerView.addGestureRecognizer(pan)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(observerOfShopListView), name: SHOPLISTVIEWADDBUTTONNOTIFICATIONNAME, object: nil)
        //添加商品或减少商品 通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(observerOfAddOrMinusShopItem(_:)), name: FIRSTSHOPITEMNOTIFICATION, object: nil )
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let bgView = navigationController?.navigationBar.subviews[0]
        bgView?.alpha = 0
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        let bgView = navigationController?.navigationBar.subviews[0]
        bgView?.alpha = 1
    }
    
    //MARK: - notification observer
    func observerOfShopListView() {
        print("observer")
        animator?.removeAllBehaviors()
    }
    
    //MARK: addOrMinus shop item noti
    func observerOfAddOrMinusShopItem(noti: NSNotification) {
        
        let userInof = noti.userInfo!
        let state = userInof["state"] as! NSString
        
        let currentState: NSString = "add"
        if state == currentState {
            count += 1
        
            
        } else {
            count -= 1
        }
        if count > 0 {
            badgeLab.hidden = false
            badgeLab.text = "\(count)"
        }
    }
    
    
    //MARK: - set bottomScrollView
    func setupBottomScrollView() {
        
        bottomScrollView.backgroundColor = UIColor.whiteColor()
        
        bottomScrollView.contentSize = CGSizeMake(width * 3, bottomScrollView.frame.size.height)
        bottomScrollView.delegate = self
        
        
        firstShopItemVC = FirstShopItemController()
        firstShopItemVC.view.frame = CGRectMake(0, 0, width, bottomScrollView.frame.size.height)
        bottomScrollView.addSubview(firstShopItemVC.view)
        addChildViewController(firstShopItemVC)
        
        secondShopItemVC = SecondShopItemController()
        secondShopItemVC.view.frame = CGRectMake(width, 0, width, bottomScrollView.frame.size.height)
        bottomScrollView.addSubview(secondShopItemVC.view)
        addChildViewController(secondShopItemVC)
        
        thirdShopItemVC = ThirdShopItemController()
        thirdShopItemVC.view.frame = CGRectMake(width * 2, 0, width, bottomScrollView.frame.size.height)
        bottomScrollView.addSubview(thirdShopItemVC.view)
        addChildViewController(thirdShopItemVC)
        
        bottomScrollView.scrollEnabled = true
        bottomScrollView.pagingEnabled = true
        bottomScrollView.bounces = false
        
        bottomScrollView.showsVerticalScrollIndicator = false
        bottomScrollView.showsHorizontalScrollIndicator = false
        bottomScrollView.tag = 100
        
        badgeLab.hidden = true
        
    }
    
    //MARK: - set right navigation Button
    func setupRightNavigationBarItem() {
        rightFirstView = createRightViewButtons()
        rightSecondView = createDotButtonView()
        rightSecondView.hidden = true
        
        rightView = UIView(frame: CGRectMake(0, 0, 116, 21))
        rightView.backgroundColor = UIColor.clearColor()
        rightView.addSubview(rightFirstView)
        rightView.addSubview(rightSecondView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightView)
    }
    
    func createRightViewButtons() -> UIView{
        let rightView = UIView(frame: CGRectMake(0,0,116,21))
        let imgs = ["搜索","拼","分享","历史记录"]
        for i in 0..<imgs.count {
            let tmpButton = UIButton(frame: CGRectMake((21 + 8) * CGFloat(i) ,0,21,21))
            tmpButton.tag = i + 100
            tmpButton.setImage(UIImage(named: imgs[i]), forState: .Normal)
            tmpButton.addTarget(self, action: #selector(buttonClicked(_:)), forControlEvents: .TouchUpInside)
            rightView.addSubview(tmpButton)
        }
        return rightView
    }
    
    func createDotButtonView() -> UIView{
        let dotView = UIView(frame: CGRectMake(116 - 30,0,30,21))
        let button = UIButton(frame: CGRectMake(0,0,30,21))
        button.tag = 200
        button.setImage(UIImage(named: "点"), forState: .Normal)
        button.addTarget(self, action: #selector(buttonClicked(_:)), forControlEvents: .TouchUpInside)
        dotView.addSubview(button)
        return dotView
    }
    //MARK: - navigation Item button clicked
    func buttonClicked(sender: UIButton) {
        animator?.removeAllBehaviors()
        if sender.tag >= 200 {
            print("dot")
        } else {
            print("first")
        }
    }

    //MARK: - segment button clicked
    
    @IBAction func segmentButtonClicked(sender: UIButton) {
        sender.selected = true
        tmpBtn?.selected = false
        tmpBtn = sender
        
        animator?.removeAllBehaviors()
        
        lastBottomScrollViewOffset.x = CGFloat(sender.tag - 100) * width
        bottomScrollView.setContentOffset(CGPointMake(CGFloat((sender.tag - 100)) * width, 0), animated: true)
    
        if sender.tag == 100 {
            shopCarContainerView.hidden = false
        } else if sender.tag == 101 {
            shopCarContainerView.hidden = true
        } else {
            shopCarContainerView.hidden = true 
        }
    }
    
    //MARK: - panGesture action
    func pan(gr: UIPanGestureRecognizer) {
        let translation = gr.translationInView(view)
        var velocity = gr.velocityInView(view)
        velocity.x = 0
        velocity.y = -velocity.y
        
        switch gr.state {
        case .Began:
            lastPointY = frontContainerView.bounds.origin.y
            animator?.removeAllBehaviors()
            lastOffset = tableViewOffset()
            
            locationEndState = 0
            
            if frontContainerView.bounds.origin.y > -1 && frontContainerView.bounds.origin.y < 1 {
                frontContainerView.bounds.origin.y = 0
            }
            
            lastGrLocation = gr.locationInView(frontContainerView)
            
            break
        case .Changed:
        
            if abs(lastGrLocation.y - gr.locationInView(frontContainerView).y) > 10 {
                //只有竖直方向运动
                bottomScrollView.scrollEnabled = false
            }
            if abs(lastGrLocation.x - gr.locationInView(frontContainerView).x) > 10 {
                if  bottomScrollView.scrollEnabled != false {
                    print("水平方向")
                    return
                }
            }
            
            currentStateChange = true
            // true 向下滑动； false 向上滑动
            velocityDirectionDown = velocity.y < 0 ? true : false
            
            var bounds = CGRectMake(0, lastPointY - translation.y, frontContainerView.frame.size.width, frontContainerView.frame.size.height)
            print("这里： tableOffset: \(tableViewOffset().y) max: \(maxOffset())")
            
            if  tableViewOffset().y >= maxOffset() {
                setTableViewOffset(CGPointMake(0, maxOffset() - translation.y * 0.5))
                if  maxOffset() != 1 {
                    bounds.origin.y = lastPointY
                }
                
                print("> maxOffset: \(translation.y)")
            } else {
                
                if  velocityDirectionDown == false { //向上滑动
                    print("向上滑动： ")
                    if bounds.origin.y >= DISTIANCETONAVIGATIONBAR {
                        setTableViewOffset(CGPointMake(0, lastOffset.y - translation.y - (DISTIANCETONAVIGATIONBAR - lastPointY)))
                    } else {
                        if  lastOffset.y == 0 {
                            
                        }
                    }
                } else { //向下移动
                    print("向下滑动： lastPointY: \(lastPointY) offset: \(lastOffset.y)")
                    if  tableViewOffset().y > 0 {
                        setTableViewOffset(CGPointMake(0, lastOffset.y - translation.y ))
                        bounds.origin.y = frontContainerView.bounds.origin.y
                    } else {
                        setTableViewOffset(CGPointZero)
                        bounds.origin.y = lastPointY + (lastOffset.y - translation.y)
                    }
                }
            }
            setOrigin(bounds.origin)
            lastChangedOffset = tableViewOffset()
            lastChangedOrigin = bounds.origin

            break
        case .Ended:
            print("End")
            print("offset: \(tableViewOffset().y)")
            bottomScrollView.scrollEnabled = true
            if  (frontContainerView.bounds.origin.y == DISTIANCETONAVIGATIONBAR || tableViewOffset().y > 0) && velocityDirectionDown == true{
                locationEndState = 2
            } else if velocityDirectionDown == false && tableViewOffset().y > maxOffset() {
                locationEndState = 3
            }
            print("state: \(locationEndState)")
            currentStateChange = false
            //bounce
            animator = UIDynamicAnimator()
            dynamicItem = LCDynamicItem()
            if  locationEndState == 2 {
                dynamicItem.center = lastChangedOffset
            } else if locationEndState == 3 {
                dynamicItem.center = lastChangedOffset
            } else {
                dynamicItem.center = lastChangedOrigin
            }
            
            let strongDecelerateBehavior = UIDynamicItemBehavior(items: [dynamicItem])
            strongDecelerateBehavior.resistance = 2.0
            strongDecelerateBehavior .addLinearVelocity(velocity, forItem: dynamicItem)
            
            weak var weakSelf = self
            var changState:Bool = false

            var origin:CGPoint = lastChangedOrigin
            var lastOriginY: CGFloat = 0
            
            strongDecelerateBehavior.action = {
                if abs(weakSelf!.lastGrLocation.x - gr.locationInView(weakSelf!.frontContainerView).x) < 15 {
                    weakSelf!.bottomScrollView.contentOffset = weakSelf!.lastBottomScrollViewOffset
                    
                }
    
                print("dynamicItem: \(weakSelf!.dynamicItem.center.y)")
                if  weakSelf!.locationEndState == 2 {
                    print("now state: \(weakSelf!.locationEndState) -- \(weakSelf!.dynamicItem.center.y)")
                    origin = weakSelf!.frontContainerView.bounds.origin
                    
                    if changState == false {
                        weakSelf!.setTableViewOffset(CGPointMake(0, weakSelf!.dynamicItem.center.y))
                    }
                    
                    if weakSelf!.dynamicItem.center.y >= weakSelf!.maxOffset() {
                        weakSelf!.setTableViewOffset(CGPointMake(0, weakSelf!.maxOffset() + (weakSelf!.dynamicItem.center.y - weakSelf!.maxOffset()) * 0.5 ))
                    }
                    
                    if  weakSelf!.dynamicItem.center.y <= 0 {
                        weakSelf!.setTableViewOffset(CGPointZero)
                        if changState == false {
                            weakSelf!.dynamicItem.center = weakSelf!.frontContainerView.bounds.origin
                            weakSelf!.animator?.updateItemUsingCurrentState(weakSelf!.dynamicItem)
                            changState = true
                            print("bool here once: \(weakSelf!.dynamicItem.center.y)")
                        }
                    }
                    if  weakSelf!.tableViewOffset().y == 0 {
                        origin.y =  (weakSelf!.dynamicItem.center.y )
                        print("1: \(origin.y)")
                    }
                    
                } else if weakSelf!.locationEndState == 3 {
                    print("here state 3")
                    weakSelf!.setTableViewOffset(weakSelf!.dynamicItem.center)
                    
                } else {
                    
                    if  origin.y >= DISTIANCETONAVIGATIONBAR {
                        if  weakSelf!.velocityDirectionDown == false {//向上
                            
                            if  weakSelf!.tableViewOffset().y < weakSelf!.maxOffset() {
                                weakSelf!.setTableViewOffset(CGPointMake(0, weakSelf!.lastChangedOffset.y + weakSelf!.dynamicItem.center.y - lastOriginY ))
                                
                                if weakSelf!.tableViewOffset().y >= weakSelf!.maxOffset() {
                                    weakSelf!.dynamicItem.center = CGPointMake(0, weakSelf!.maxOffset())
                                    weakSelf!.animator?.updateItemUsingCurrentState(weakSelf!.dynamicItem)
                                }
                                
                                print("offset < max: \(weakSelf?.tableViewOffset().y) ")
                            } else {
                                //update dynamicItem to apply tableViewOffset
                                
                                weakSelf!.setTableViewOffset(weakSelf!.dynamicItem.center)
                                print("offset > max: \(weakSelf?.tableViewOffset().y) ")
                            }
                            
                        }
                        
                    } else {
                        origin.y = weakSelf!.dynamicItem.center.y
                        lastOriginY = origin.y
                        print("originY: \(origin.y) ")
                    }
                }
                weakSelf!.setOrigin(origin)
                
            }
            animator?.addBehavior(strongDecelerateBehavior)
            self.decelerateBehavior = strongDecelerateBehavior
            
            break
            
        default: break
        }
    }
    
    //MARK: setOrigin
    func setOrigin(origin: CGPoint)  {
        frontContainerView.bounds.origin = origin
        
        if  tableViewOffset().y <= 0 {
            setTableViewOffset(CGPointZero)
        }
        
        
        if frontContainerView.bounds.origin.y >= DISTIANCETONAVIGATIONBAR {
            frontContainerView.bounds.origin = CGPointMake(0, DISTIANCETONAVIGATIONBAR)
        }
        
        if frontContainerView.bounds.origin.y <= 40  {
            showFirstView(true)
            adsContainerView.hidden = false
            adsContainerView.alpha = 1
            rightView.alpha = (deltY - frontContainerView.bounds.origin.y)/deltY
            bgContainerView.alpha = rightView.alpha
            
        } else if frontContainerView.bounds.origin.y > 40 && frontContainerView.bounds.origin.y <= DISTIANCETONAVIGATIONBAR {
            rightView.alpha = 1
            
            adsContainerView.alpha = (deltSecondY - 10 - (frontContainerView.bounds.origin.y - 40)) / deltSecondY
            adsContainerView.hidden = false
            
            showFirstView(false)
        } else if frontContainerView.bounds.origin.y > DISTIANCETONAVIGATIONBAR {
            adsContainerView.hidden = true
        }
        
        //add attachment spring behavior
        if (decelerateBehavior != nil && springBehavior == nil) && (frontContainerView.bounds.origin.y < 0 || tableViewOffset().y > maxOffset() ){
            print("spring: bounds \(frontContainerView.bounds.origin.y) offset \(tableViewOffset().y) maxoffset \(maxOffset())")
            let strongSpringBehavior = UIAttachmentBehavior(item: dynamicItem, attachedToAnchor: CGPointMake(0, 0))
            
            if  frontContainerView.bounds.origin.y < 0 {
                strongSpringBehavior.length = 0
            } else if tableViewOffset().y > maxOffset() {
                strongSpringBehavior.length = maxOffset()
                print("here -- here ")
            }
            
            strongSpringBehavior.damping = 1
            strongSpringBehavior.frequency = 2.0
            
            animator?.addBehavior(strongSpringBehavior)
            springBehavior = strongSpringBehavior
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName(BOUNDSCHANGEDNOTIFICATIONNAME, object: nil, userInfo: ["boundsY":frontContainerView.bounds.origin.y])
    }

    
    func showFirstView(isShow: Bool) {
        if isShow == true {
            rightSecondView.hidden = true
            rightFirstView.hidden = false
            
            title = ""
        } else {
            rightSecondView.hidden = false
            rightFirstView.hidden = true
            
            title = "黄太吉（建外工厂店）"
        }
    }
    
    
    //MARK: pan gesture simultaneously
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    //MARK: scrollView delegate
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if scrollView == bottomScrollView {
            print("begin: \(scrollView.contentOffset)")
            lastBottomScrollViewOffset = scrollView.contentOffset
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView == bottomScrollView {
            print("scroll xy \(scrollView.contentOffset)")
            let sliderWidth = sliderView.frame.size.width
            let scaleValue = scrollView.contentOffset.x / scrollView.frame.size.width
            sliderViewLeadingConstraint.constant = scaleValue * sliderWidth
            
            if  abs(scrollView.contentOffset.x - lastBottomScrollViewOffset.x) > 10 {
                print("scroll 横向运动")
                pan.enabled = false
                
            }
            
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView == bottomScrollView {
            let  index = scrollView.contentOffset.x / scrollView.frame.size.width
            setBtnSelectedState(NSInteger(index))
            pan.enabled = true
            print("scroll 结束")
        }
        
    }
    
    func setBtnSelectedState(index: NSInteger) {
        if  index == 0 {
            segmentButtonClicked(shopOfSegmentButton)
        } else if index == 1 {
            segmentButtonClicked(evaluationButton)
        } else {
            segmentButtonClicked(businessButton)
        }
    }
    
    //MARK: deinit
    deinit {
        animator?.removeAllBehaviors()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

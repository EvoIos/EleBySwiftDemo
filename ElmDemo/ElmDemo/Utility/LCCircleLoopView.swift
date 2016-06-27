//
//  LCCircleLoopView.swift
//  LCCircleLoopView
//
//  Created by z on 16/5/31.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

let LCCircleLoopViewTimeInterval = 2.0

@objc protocol LCCircleLoopViewDelegate: class {
    /**
     LCCircleLoopView tap action delegate
     - parameter currentIndex: the index of current image
     */
    optional
    func clickedImageAction(currentIndex: NSInteger)
}

class LCCircleLoopView: UIView, UIScrollViewDelegate {
    
    weak var delegate: LCCircleLoopViewDelegate?
    
    private var imgNames: [String]!
    private var containerScrollView: UIScrollView!
    private  var containerImgViews: [UIImageView]!
    
    private var currentImgView:     UIImageView!
    private var nextImgView:        UIImageView!
    private var previousImgView:    UIImageView!
    
    // index
    private var currentIndex: NSInteger = 0
    private var nextIndex: NSInteger = 1
    //need update in setImgNames:
    private var previousIndex: NSInteger = 0
    
    private var pageIndicator:      UIPageControl!
    private var timer: NSTimer!
    
    //MARK: -
    //MARK: public func
    func startTimer() {
        if timer == nil {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(LCCircleLoopViewTimeInterval, target: self, selector: #selector(LCCircleLoopView.timerAction), userInfo: nil, repeats: true)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func setImgNames(imgNamesArray imgNamesArray: [String]) {
        imgNames = imgNamesArray
        //required  three photos at least
        if imgNames.count < 3 {
            print("error: need three photos at least！")
            return
        }
        //updateUI
        updateUI()
        //update previousIndex to new value
        previousIndex = imgNames.count - 1
        //set pageControl
        pageIndicator.numberOfPages = imgNames.count
        //set timer
        startTimer()
        //update scrollView UI
        updateScrollView()
    }
    
    func updateScrollView()  {
        currentImgView.image = UIImage(named: imgNames[currentIndex])
        nextImgView.image = UIImage(named: imgNames[nextIndex])
        previousImgView.image = UIImage(named: imgNames[previousIndex])
        containerScrollView.setContentOffset(CGPointMake(bounds.size.width, 0), animated: false)
    }
    
    func timerAction()  {
        containerScrollView.setContentOffset(CGPointMake(bounds.size.width * 2, 0), animated: true)
    }
    
    //MARK: -
    //MARK: life cycle
    required override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func  setupUI() {
        //use bounds not frame
        containerScrollView = UIScrollView()

        containerScrollView.pagingEnabled = true
        containerScrollView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        containerScrollView.showsHorizontalScrollIndicator = false
        containerScrollView.delegate = self
        addSubview(containerScrollView)
        
        
        currentImgView = UIImageView()
        currentImgView.userInteractionEnabled = true
        currentImgView.contentMode = UIViewContentMode.ScaleAspectFill
        currentImgView.clipsToBounds = true
        containerScrollView.addSubview(currentImgView)
        
        nextImgView = UIImageView()
        
        nextImgView.userInteractionEnabled = true
        nextImgView.contentMode = UIViewContentMode.ScaleAspectFill
        nextImgView.clipsToBounds = true
        containerScrollView.addSubview(nextImgView)
        
        previousImgView = UIImageView()
        previousImgView.userInteractionEnabled = true
        previousImgView.contentMode = UIViewContentMode.ScaleAspectFill
        previousImgView.clipsToBounds = true
        containerScrollView.addSubview(previousImgView)
        
        //pageIndicator
        pageIndicator = UIPageControl()
       
        pageIndicator.hidesForSinglePage = true
        pageIndicator.numberOfPages = 0
        pageIndicator.backgroundColor = UIColor.clearColor()
        addSubview(pageIndicator)
        
        //add tap action
        let tap = UITapGestureRecognizer(target: self, action: #selector(LCCircleLoopView.tapClicked(_:)))
        containerScrollView.addGestureRecognizer(tap)
        
        //updateUI
        updateUI()
    }
    
    //awake from XIB
    func updateUI() {
        containerScrollView.frame = bounds
        containerScrollView.contentSize = CGSizeMake(bounds.size.width * 3, bounds.size.height)
        containerScrollView.setContentOffset(CGPointMake(bounds.size.width, 0), animated: false)
        
        currentImgView.frame = CGRectMake(bounds.size.width, 0, bounds.size.width, bounds.size.height)
        nextImgView.frame = CGRectMake(bounds.size.width * 2, 0, bounds.size.width, bounds.size.height)
        previousImgView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
        
        pageIndicator.frame = CGRectMake(0,bounds.size.height - 20, bounds.size.width, 20)
        pageIndicator.center = CGPoint(x: bounds.size.width / 2.0, y: pageIndicator.center.y)
    }
    
    func tapClicked(tapGR: UITapGestureRecognizer) {
        self.delegate?.clickedImageAction!(currentIndex)
    }
    
    //MARK: - 
    //MARK: scroll delegate
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        
        if offset == 0 {
            previousIndex = getImgIndex(index: previousIndex, left: true)
            currentIndex = getImgIndex(index: currentIndex, left: true)
            nextIndex = getImgIndex(index: nextIndex, left: true)
        }else if offset == self.frame.size.width * 2 {
            previousIndex = getImgIndex(index: previousIndex, left: false)
            currentIndex = getImgIndex(index: currentIndex, left: false)
            nextIndex = getImgIndex(index: nextIndex, left: false)
        }
        //set currentPage
        pageIndicator.currentPage = currentIndex
        //update UI
        updateScrollView()
        //reset timer
        startTimer()
    }
    
    //timer action set contentoffset then take this function
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(scrollView)
    }
    
    private func getImgIndex(index index: NSInteger, left: Bool) -> NSInteger {
        if left == true {
            let tmpIndex = index - 1
            if tmpIndex == -1 {
                return imgNames.count - 1
            } else {
                return tmpIndex
            }
        } else {
            let tmpIndex = index + 1
            if tmpIndex >= imgNames.count {
                return 0
            } else {
                return tmpIndex
            }
        }
    }
    
    //MARK: dealloc(OC), deinit(swift)
    deinit {
        stopTimer()
    }
    
    
}

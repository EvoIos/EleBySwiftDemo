//
//  AppDelegate.swift
//  ElmDemo
//
//  Created by zhenglanchun on 16/5/29.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

@UIApplicationMain


class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow.init(frame:UIScreen.mainScreen().bounds)
        
        let takeawayVC = TakeawayViewController()
        let orederVC = OrderController()
        let exploreVC = ExploreController()
        let mineVC = MineController()
        let controllers = [takeawayVC, orederVC, exploreVC, mineVC]
        
        let tabbarVC = UITabBarController.init()
        tabbarVC.viewControllers = controllers
        
        let nav = UINavigationController.init(rootViewController: tabbarVC)
        nav.navigationBar.barTintColor = NAVBG_COLOR
        //统一设定 navigation title颜色
        let navigationBarApperace = UINavigationBar.appearance()
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationBarApperace.titleTextAttributes = titleDict as? [String: AnyObject]
        
        takeawayVC.tabBarItem = UITabBarItem(
            title: "外卖",
            image: UIImage(named: "外卖-边框"),
            selectedImage: UIImage(named: "外卖-填充")
        )
        
        orederVC.tabBarItem = UITabBarItem(
            title: "订单",
            image: UIImage(named: "订单-边框"),
            selectedImage: UIImage(named: "订单-填充")
        )
        
        exploreVC.tabBarItem = UITabBarItem(
            title: "发现",
            image: UIImage(named: "发现-边框"),
            selectedImage: UIImage(named: "发现-填充")
        )
        mineVC.tabBarItem = UITabBarItem(
            title: "我的",
            image: UIImage(named: "我的-边框"),
            selectedImage: UIImage(named: "我的-填充")
        )

        window?.rootViewController = nav;
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


//
//  ExploreController.swift
//  ElmDemo
//
//  Created by zhenglanchun on 16/5/29.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class ExploreController: UIViewController {

    var webView: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView = UIWebView(frame: view.bounds)
        view.addSubview(webView!)
        
        webView!.loadRequest(NSURLRequest(URL: NSURL(string: WEBURL)!))
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.navigationItem.title = "发现"
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

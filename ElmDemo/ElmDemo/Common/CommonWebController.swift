//
//  CommonWebController.swift
//  ElmDemo
//
//  Created by zhenglanchun on 16/6/26.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class CommonWebController: UIViewController {

    let urlStr: String = WEBURL
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setleftBarButtonItem("向左箭头")
        
        // Do any additional setup after loading the view.
        webView.loadRequest(NSURLRequest(URL: NSURL(string: urlStr)!))
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

//
//  MineController.swift
//  ElmDemo
//
//  Created by zhenglanchun on 16/6/26.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class MineController: UIViewController {

    @IBOutlet weak var headContainerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        headContainerView.backgroundColor = UIColor(red: 75.0/255.0, green: 161.0/255.0, blue: 228.0/255.0, alpha: 1)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setRightBarButtonItemInTabBarController("设置", rightBtnClicked: #selector(rightItemClicked))
        tabBarController?.navigationItem.title = "我的"
    }

    func rightItemClicked() {
    
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

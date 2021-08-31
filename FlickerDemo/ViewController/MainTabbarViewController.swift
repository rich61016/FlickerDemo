//
//  MainTabbarViewController.swift
//  FlickerDemo
//
//  Created by YA on 2021/8/30.
//

import UIKit

class MainTabbarViewController: UITabBarController {
    
     var navtitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "搜尋結果 \(navtitle!)"
      
        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
       
        if item.tag != 0{
            self.navigationItem.title = "我的最愛"
            self.navigationItem.hidesBackButton = true
        }else{
            self.navigationItem.title = "搜尋結果 \(navtitle!)"
            self.navigationItem.hidesBackButton = false
        }
    }

}

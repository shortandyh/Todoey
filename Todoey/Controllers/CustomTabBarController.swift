//
//  File.swift
//  Todoey
//
//  Created by stone_1 on 19/10/2018.
//  Copyright © 2018 stone1. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwipeableTabBarController

class CustomTabBarController: SwipeableTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSwipeAnimation(type: SwipeAnimationType.overlap)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        print("Selected item", item.tag )
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.hidesBottomBarWhenPushed = true
    }
    
    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        print("Selected view controller", viewController)
//        print("index", tabBarController.selectedIndex )
////        SVProgressHUD.setDefaultStyle(.dark)
////        SVProgressHUD.show(withStatus: "Loading Camera View")
//    }
    
}

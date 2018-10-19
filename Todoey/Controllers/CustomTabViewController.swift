//
//  File.swift
//  Todoey
//
//  Created by stone_1 on 19/10/2018.
//  Copyright © 2018 stone1. All rights reserved.
//

import UIKit
import SVProgressHUD

class CustomTabViewController: UITabBarController,UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        print("Selected item", item.tag )
        
        
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected view controller", viewController)
        print("index", tabBarController.selectedIndex )
//        SVProgressHUD.setDefaultStyle(.dark)
//        SVProgressHUD.show(withStatus: "Loading Camera View")
    }
    
}

//
//  MainTabBarController.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/9.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC("Home")
        addChildVC("Rank")
        addChildVC("Discover")
        addChildVC("Profile")
       
    }


    fileprivate func addChildVC(_ storyName: String) {
        
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVC)
        
    }

}

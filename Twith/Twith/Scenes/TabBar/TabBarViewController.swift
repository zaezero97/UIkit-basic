//
//  TabBarViewController.swift
//  Twith
//
//  Created by 재영신 on 2022/01/24.
//

import UIKit



final class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarViewControllers: [UIViewController] = TabBarItem.allCases
            .map{
                let vc = $0.viewController
                vc.tabBarItem = UITabBarItem(
                    title: $0.title,
                    image: $0.icon.default,
                    selectedImage: $0.icon.selected
                )
                return vc
            }
        self.viewControllers = tabBarViewControllers
    }
}

//
//  TabbarController: .swift
//  Translate
//
//  Created by 재영신 on 2022/01/21.
//

import UIKit
import SwiftUI

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let translateVC = TranslateViewController()
        translateVC.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Translate", comment: "번역"),
            image: UIImage(systemName: "mic"),
            selectedImage: UIImage(systemName: "mic.fill")
        )
        
        let bookmarkVC = UINavigationController(rootViewController: BookmarkViewController())
        bookmarkVC.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Bookmarks", comment: "즐겨찾기"),
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )
        
        self.viewControllers = [translateVC,bookmarkVC]
    }
}

struct TabBarController_Preview : PreviewProvider {
    static var previews: some View {
        Contatiner().edgesIgnoringSafeArea(.all)
    }
    struct Contatiner: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return UINavigationController(rootViewController: TabBarController())
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        typealias UIViewControllerType =  UIViewController
    }
}

//
//  SceneDelegate.swift
//  Translate
//
//  Created by 재영신 on 2022/01/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        self.window?.backgroundColor = .systemBackground
        self.window?.rootViewController = UINavigationController(rootViewController: TabBarController())
        self.window?.tintColor = UIColor.mainTintColor
        self.window?.makeKeyAndVisible()
    }
    
    
}



//
//  AppDelegate.swift
//  SocialLogin
//
//  Created by 재영신 on 2022/01/17.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKCommon
import NaverThirdPartyLogin
import GoogleSignIn
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //kakao
        KakaoSDK.initSDK(appKey:"8012bae003498ed5a6a5e8803c739566")
        
        //google
        
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                print("구글 로그인 안돼있음")
                //logout state
            } else {
                print("이미 구글 로그인 !!")
                // login state
            }
        }
        
        
        //naver
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        instance?.isNaverAppOauthEnable = true
        instance?.isInAppOauthEnable = true
        
        instance?.serviceUrlScheme = kServiceAppUrlScheme
        instance?.consumerKey = kConsumerKey
        instance?.consumerSecret = kConsumerSecret
        instance?.appName = kServiceAppName
        return true
    }
    // MARK: UISceneSession Lifecycle
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)
        
        var handled: Bool

         handled = GIDSignIn.sharedInstance.handle(url)
         if handled {
           return true
         }

         // Handle other custom URL types.

         // If not handled by this app, return false.
         return false
        
    }
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}


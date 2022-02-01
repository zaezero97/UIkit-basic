//
//  AppDelegate.swift
//  Remote-push
//
//  Created by 재영신 on 2022/02/01.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
    
        //FCM 현재 등록 토큰 확인
        Messaging.messaging().token { token, error in
            if let error = error {
                print("ERROR FCM 등록 토큰 가져오기: \(error.localizedDescription)")
            } else if let token = token {
                print("FCM 등록 토큰: \(token)")
            }
        }
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        //로컬 및 원격 알림이 사용자의 장치에 전달될 때 사용자와 상호 작용할 수 있는 권한을 요청합니다.
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, error in
            print("Error, Request Notifications Authorication: \(error.debugDescription)")
        }
        
        //APNs 등록??
        application.registerForRemoteNotifications()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

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


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Device TOKEN!!!\(deviceToken)")
        //IRMessaging은 APN 토큰이 자동으로 설정되도록 하기 위해 메소드 스위즐링을 사용합니다. 그러나 앱의 Info.plist에서 'FirebaseAppDelegateProxyEnabled'를 'NO'로 설정하여 스위즐링을 비활성화한 경우에는 애플리케이션 대리자의 '-application:DidRemote Notifications WithDeviceToken:' 메서드에서 APN 토큰을 수동으로 설정해야 합니다.
        //Messaging.messaging().apnsToken = deviceToken
    }
    //notification 이 왔을 때
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .badge, .sound])
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken = fcmToken else { return  }
        //서버로 전송해야함 원래
        print("FCM 등록 토큰 갱신: \(fcmToken)")
    }
}

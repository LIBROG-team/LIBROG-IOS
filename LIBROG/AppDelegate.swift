//
//  AppDelegate.swift
//  LIBROG
//
//  Created by 최승희 on 2022/06/30.
//

import UIKit
import KakaoSDKAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                return AuthController.handleOpenUrl(url: url)
            }

            return false
        }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        sleep(2)
        
        UserDefaults.standard.set("e9e63756ebc5c4ceeac89815995e2fd8", forKey: "KAKAO_REST_API_KEY")
        UserDefaults.standard.set("https://dev.siejwkaodj.shop/", forKey: "url")
        UserDefaults.standard.set("", forKey: "accessToken")
        UserDefaults.standard.set("", forKey: "refreshToken")
        UserDefaults.standard.set(1, forKey: "userId")  // 임시로 userID를 1로 설정
        
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


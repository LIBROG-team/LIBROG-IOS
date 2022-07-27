//
//  KakaoLoginManager.swift
//  LIBROG
//
//  Created by gomin on 2022/07/27.
//

import Foundation
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

class KakaoLoginManager {
    //MARK: 카카오 로그인
    func kakaoLogin(_ viewcontroller: LoginViewController) {
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    //do something
                    _ = oauthToken
                    let accessToken = oauthToken?.accessToken
                    let refreshToken = oauthToken?.refreshToken
                    UserDefaults.standard.set(accessToken, forKey: "accessToken")
                    UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
                    
                    self.setKakaoUserInfo()
                }
            }
        }
        else {
            // MARK: 카카오톡 로그인 - 웹으로 이동
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
               if let error = error {
                 print(error)
               }
               else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
                   let accessToken = oauthToken?.accessToken
                   let refreshToken = oauthToken?.refreshToken
                   UserDefaults.standard.set(accessToken, forKey: "accessToken")
                   UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
                   
                   self.setKakaoUserInfo()
               }
            }
        }
    }
    func setKakaoUserInfo() {
        //사용자 관리 api 호출
        UserApi.shared.me() {(user, error) in
            if let error = error {print(error)}
            else {
                print("me() success.")
                //do something
                _ = user
            }
        }
    }
    // MARK: 카카오 로그아웃
    func kakaoLogout() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
            }
        }
    }
}

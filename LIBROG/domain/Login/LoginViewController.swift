//
//  LoginViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/22.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func kakaoLoginButtonDidTap(_ sender: UIButton) {
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
                   self.setUserInfo()
               }
            }
        }
    }
    @IBAction func kakaoLogoutButtonDidTap(_ sender: UIButton) {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
            }
        }
    }
    func setUserInfo() {
        //사용자 관리 api 호출
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
        //do something
                _ = user
            }
        }
    }
}

//
//  LoginDataManager.swift
//  LIBROG
//
//  Created by gomin on 2022/07/27.
//

import Foundation
import Alamofire
import Kingfisher

class LoginDataManager {
    let url = UserDefaults.standard.string(forKey: "url")
    
    //MARK: 앱 로그인
    func appLoginDataManager(_ parameter: AppLoginInput, _ viewcontroller: LoginViewController) {
        AF.request(url! + "auth/login",
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: APIModel<AppLoginModel>.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result)
                viewcontroller.loginSuccessAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    //MARK: 앱 로그인 -> 회원가입 이후
    func appLoginDataManager(_ parameter: AppLoginInput, _ viewcontroller: RegisterProfileViewController) {
        AF.request(url! + "auth/login",
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: APIModel<AppLoginModel>.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result)
                viewcontroller.loginSuccessAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    //MARK: Kakao 로그인
    func kakaoLoginDataManager(_ parameter: KakaoLoginInput, _ viewcontroller: LoginViewController) {
        AF.request(url! + "users/kakao/certificate/",
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: APIModel<KakaoLoginModel>.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result.result)
                viewcontroller.loginSuccessAPI(result.result!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

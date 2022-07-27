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
    
    func kakaoLoginDataManager(_ parameter: KakaoLoginInput, _ viewcontroller: LoginViewController) {
        AF.request(url! + "users/kakao/certificate/",
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: KakaoLoginModel.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result.result)
                viewcontroller.loginSuccessAPI()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

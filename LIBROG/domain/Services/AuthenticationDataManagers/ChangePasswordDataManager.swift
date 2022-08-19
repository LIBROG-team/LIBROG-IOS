//
//  ChangePasswordDataManager.swift
//  LIBROG
//
//  Created by gomin on 2022/08/19.
//

import Foundation
import Alamofire
import Kingfisher

class ChangePasswordDataManager {
    let url = UserDefaults.standard.string(forKey: "url")
    let accessToken = UserDefaults.standard.string(forKey: "accessToken")
    
    func changePasswordDataManager(_ parameter: ChangePasswordInput, _ viewcontroller: ChangePasswordViewController) {
        // 토큰을 포함한 헤더 설정
        let headers: HTTPHeaders = [
            "x-access-token": accessToken!
        ]
        AF.request(url! + "users/password/change",
                   method: .patch,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
            .validate()
            .responseDecodable(of: APIModel<ChangePasswordModel>.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result)
                if result.isSuccess! {viewcontroller.changePasswordSuccessAPI(result)}
                else {DialogManager().alertErrorDialog(result.message!, viewcontroller)}
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


//
//  RegisterDataManager.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/28.
//

import Foundation
import Alamofire
import Kingfisher

class RegisterDataManager {
    let url = UserDefaults.standard.string(forKey: "url")
    
    func registerDataManager(_ parameter: RegisterInput, _ viewcontroller: RegisterViewController) {
        AF.request(url! + "users/",
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: APIModel<ResultModel>.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result)
                viewcontroller.RegisterSuccessAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

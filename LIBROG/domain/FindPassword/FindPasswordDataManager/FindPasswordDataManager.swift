//
//  FindPasswordDataManager.swift
//  LIBROG
//
//  Created by gomin on 2022/08/11.
//

import Foundation
import Alamofire
import Kingfisher

class FindPasswordDataManager {
    let url = UserDefaults.standard.string(forKey: "url")
    
    func findPasswordDataManager(_ parameter: FindPasswordInput, _ viewcontroller: FindPasswordViewController) {
        AF.request(url! + "users/findMyPassword/",
                   method: .patch,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: APIModel<ResultModel>.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result)
                viewcontroller.findPasswordSuccessAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


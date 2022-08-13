//
//  SettingDataManager.swift
//  LIBROG
//
//  Created by gomin on 2022/08/14.
//

import Foundation
import Alamofire
import Kingfisher

class SettingDataManager {
    let url = UserDefaults.standard.string(forKey: "url")
    
    func userDeleteDataManager(_ viewcontroller: SettingViewController) {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        AF.request(url! + "users/userDelete/\(userId)",
                   method: .delete,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<APIModel<DeleteUserModel>>.self) { response in

            switch response.result {
            case .success(let result):
                print("DEBUG: ", result)
                viewcontroller.userDeleteSuccessAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


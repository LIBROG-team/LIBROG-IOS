//
//  FlowerpotDataManager.swift
//  LIBROG
//
//  Created by gomin on 2022/07/19.
//

import Foundation
import Alamofire
import Kingfisher

class FlowerpotDataManager {
    let url = UserDefaults.standard.string(forKey: "url")
    
    let userId = UserDefaults.standard.integer(forKey: "userId")
    func flowerpotDataManager(_ viewcontroller : FlowerPotViewController) {
        AF.request(url! + "flowerpots/\(userId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: FlowerpotModel.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result.result)
                viewcontroller.userFlowerPotSuccessAPI(result.result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

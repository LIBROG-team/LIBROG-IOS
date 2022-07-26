//
//  StatisticDataManager.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/26.
//

import Foundation
import Alamofire
import Kingfisher

class StatisticDataManager {
    let url = UserDefaults.standard.string(forKey: "url")
    let userId = UserDefaults.standard.integer(forKey: "userId")
    
    func statisticDataManager(_ viewcontroller: ProfileViewController) {
        AF.request(url! + "records/statistics/\(userId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: StatisticModel.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result)
                viewcontroller.statisticSuccessAPI(result.result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

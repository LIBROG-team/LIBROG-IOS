//
//  StatisticDataManager.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/26.
//

import Foundation
import Alamofire
import Kingfisher

class ProfileDataManager {
    let url = UserDefaults.standard.string(forKey: "url")
    let userId = UserDefaults.standard.integer(forKey: "userId")
    
    // MARK: 유저 정보 조회
    func introDataManager(_ viewcontroller: ProfileViewController) {
        AF.request(url! + "users/introduce/\(userId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: IntroModel.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result)
                viewcontroller.introSuccessAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: 유저의 독서 통계 조회
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

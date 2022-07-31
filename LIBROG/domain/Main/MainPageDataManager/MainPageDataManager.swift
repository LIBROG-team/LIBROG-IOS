//
//  MainPageDataManager.swift
//  LIBROG
//
//  Created by gomin on 2022/07/18.
//


import Alamofire
import Kingfisher
import UIKit

class MainPageDataManager{
    let url = UserDefaults.standard.string(forKey: "url")
    let userId = UserDefaults.standard.integer(forKey: "userId")
    
    func mainPageFlowerpotDataManager(_ userIdx: Int, _ viewcontroller : MainViewController) {
        AF.request(url! + "flowerpots/\(userIdx)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: FlowerpotModel.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result.result[1])
                viewcontroller.userFlowerPotSuccessAPI(result.result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func recentBookDataManager(_ viewcontroller : MainBottomViewController) {
        AF.request(url! + "records/bookRecords/\(userId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: [RecentBookModel].self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result)
                viewcontroller.recentBookSuccessAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

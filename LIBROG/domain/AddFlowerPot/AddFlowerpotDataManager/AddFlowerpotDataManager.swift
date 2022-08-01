//
//  AddFlowerpotDataManager.swift
//  LIBROG
//
//  Created by gomin on 2022/07/21.
//

import Foundation
import Alamofire
import Kingfisher

class AddFlowerpotDataManager {
    let url = UserDefaults.standard.string(forKey: "url")
    let userId = UserDefaults.standard.string(forKey: "userId")
    
    func addAchievedFlowerpotDataManager(_ viewcontroller: AchievedFlowerPotViewController) {
        AF.request(url! + "flowerpots/\(userId!)/userflowerlist",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: AddFlowerpotModel.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result.result)
                viewcontroller.addFlowerpotAchievedSuccessAPI(result.result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func addNotAchievedFlowerpotDataManager(_ viewcontroller: NotAchievedFlowerPotViewController) {
        AF.request(url! + "flowerpots/\(userId!)/unacqUserflowerlist",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: NotAchievedSearchFlowerpotModel.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result.result)
                viewcontroller.addFlowerpotNotAchievedSuccessAPI(result.result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

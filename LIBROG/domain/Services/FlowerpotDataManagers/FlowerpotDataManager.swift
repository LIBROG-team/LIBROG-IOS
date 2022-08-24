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
    //MARK: 유저의 화분 가져오기 api
    func flowerpotDataManager(_ viewcontroller : FlowerPotViewController) {
        AF.request(url! + "flowerpots/\(userId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<[FlowerpotData]>.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result.result)
                viewcontroller.userFlowerPotSuccessAPI(result.result!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: 조건에 맞는 화분 추가 api
    // 독서기록 추가 시
    func addNewFlowerpotDataManager(_ viewcontroller: UploadRecordViewController) {
        AF.request(url! + "flowerpots/new/\(userId)",
                   method: .post,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<NewFlowerpotModel>.self) { response in
                
            switch response.result {
            case .success(let result):
                if result.isSuccess! {
                    viewcontroller.addNewFlowerpotSuccessAPI(result)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // 화분 추가 시
    func addNewFlowerpotDataManager(_ viewcontroller: FlowerPotDescriptionViewController) {
        AF.request(url! + "flowerpots/new/\(userId)",
                   method: .post,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<NewFlowerpotModel>.self) { response in
                
            switch response.result {
            case .success(let result):
                if result.isSuccess! {
                    viewcontroller.addNewFlowerpotSuccessAPI(result)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

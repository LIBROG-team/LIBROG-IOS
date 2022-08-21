//
//  FlowerpotDescriptionDataManager.swift
//  LIBROG
//
//  Created by gomin on 2022/07/21.
//

import Foundation
import Alamofire
import Kingfisher

class FlowerpotDescriptionDataManager {
    let url = UserDefaults.standard.string(forKey: "url")
    // MARK: 화분 상세 조회
    func getFlowerpotDescriptionDataManager(_ flowerpotId: Int, _ viewcontroller: FlowerPotDescriptionViewController) {
        AF.request(url! + "flowerpots/flowerPotInfo/\(flowerpotId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<[FlowerpotDescriptionData]>.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result.result)
                viewcontroller.flowerpotDescriptionSuccessAPI(result.result![0])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: 획득 화분에서 화분 추가
    func addAcqFlowerpotDataManager(_ flowerpotListId: Int, _ viewcontroller: FlowerPotDescriptionViewController) {
        AF.request(url! + "flowerpots/flowerpotAdd/\(flowerpotListId)",
                   method: .post,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<ResultModel>.self) { response in
                
            switch response.result {
            case .success(let result):
                print("획득 화분에서 화분 추가 성공 ", result)
                viewcontroller.addAcqFlowerpotSuccessAPI()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

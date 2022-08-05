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
}

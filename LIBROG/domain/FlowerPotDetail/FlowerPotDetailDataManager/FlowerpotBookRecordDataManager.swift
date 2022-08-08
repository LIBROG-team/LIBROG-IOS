//
//  FlowerpotBookRecordDataManager.swift
//  LIBROG
//
//  Created by gomin on 2022/07/20.
//

import Foundation
import Alamofire
import Kingfisher

class FlowerpotBookRecordDataManager {
    let url = UserDefaults.standard.string(forKey: "url")
    
    func getFlowerpotBookRecord(_ flowerpotId: Int, _ viewcontroller: FlowerPotDetailViewController) {
        AF.request(url! + "records/flowerpot/\(flowerpotId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<[ReadingRecordData]>.self) { response in
                
            switch response.result {
            case .success(let result):
                if let recordData = result.result {
                    viewcontroller.userFlowepotBookRecordSuccessAPI(recordData)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

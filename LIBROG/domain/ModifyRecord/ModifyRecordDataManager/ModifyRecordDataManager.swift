//
//  ModifyRecordDataManager.swift
//  LIBROG
//
//  Created by gomin on 2022/07/28.
//

import Foundation
import Alamofire
import Kingfisher

class ModifyRecordDataManager {
    let url = UserDefaults.standard.string(forKey: "url")
    
    func modifyRecordDataManager(_ parameter: ModifyRecordInput, _ tableviewCell: ModifyRecordTableViewCell) {
        AF.request(url! + "records/fix",
                   method: .patch,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: ModifyRecordModel.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result)
                tableviewCell.modifyRecordSuccessAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

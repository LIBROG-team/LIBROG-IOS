//
//  UploadRecordDataManager.swift
//  LIBROG
//
//  Created by gomin on 2022/07/26.
//

import Foundation
import Alamofire
import Kingfisher

class UploadRecordDataManager {
    let url = UserDefaults.standard.string(forKey: "url")
    
    func uploadRecordDataManager(_ parameter: UploadRecordInput, _ tableviewCell: UploadRecordTableViewCell) {
        AF.request(url! + "records/addition",
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: UploadRecordModel.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result.result)
                tableviewCell.uploadRecordSuccessAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

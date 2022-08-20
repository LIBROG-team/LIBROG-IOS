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
    
    func uploadRecordDataManager(_ parameter: UploadRecordInput, _ viewcontroller: UploadRecordViewController) {
        AF.request(url! + "records/addition",
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: APIModel<UploadRecordModel>.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result.result)
                viewcontroller.uploadRecordSuccessAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

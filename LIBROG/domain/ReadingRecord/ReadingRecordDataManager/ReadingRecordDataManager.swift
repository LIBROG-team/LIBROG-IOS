//
//  ReadingRecordDataManager.swift
//  LIBROG
//
//  Created by gomin on 2022/07/20.
//

import Foundation
import Alamofire
import Kingfisher

class ReadingRecordDataManager {
    let url = UserDefaults.standard.string(forKey: "url")
    let userId = UserDefaults.standard.integer(forKey: "userId")
    
    func readingRecordDataManager(_ viewcontroller: ReadingRecordViewController) {
        AF.request(url! + "records/user/\(userId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: ReadingRecordModel.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result.result)
                viewcontroller.userReadingRecordSuccessAPI(result.result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

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
    
    // MARK: 독서기록 수정
    func modifyRecordDataManager(_ parameter: ModifyRecordInput, _ viewcontroller: ModifyRecordViewController) {
        AF.request(url! + "records/fix",
                   method: .patch,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: APIModel<ResultModel>.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result)
                viewcontroller.modifyRecordSuccessAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: 독서기록 삭제
    func deleteRecordDataManager(_ parameter:DeleteRecordInput, _ viewcontroller: ModifyRecordViewController) {
        AF.request(url! + "records/removal",
                   method: .delete,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: APIModel<ResultModel>.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result)
                if result.isSuccess! {viewcontroller.deleteRecordSuccessAPI()}
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//
//  RecordDetailDataManager.swift
//  LIBROG
//
//  Created by gomin on 2022/07/30.
//
import Foundation
import Alamofire
import Kingfisher

class RecordDetailDataManager {
    let url = UserDefaults.standard.string(forKey: "url")
    
    func recordDetailDataManager(_ recordId: Int, _ viewcontroller: RecordDetailViewController) {
        AF.request(url! + "records/\(recordId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<RecordDetailModel>.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result.resblt)
                viewcontroller.recordDetailSuccessAPI(result.result!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func deleteRecordDataManager(_ parameter:DeleteRecordInput, _ viewcontroller: RecordDetailViewController) {
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

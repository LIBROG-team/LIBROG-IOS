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
                print("독서 상세 조회: ", result)
                if result.isSuccess! {viewcontroller.recordDetailSuccessAPI(result.result!)}
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

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
    // MARK: 유저별 독서기록 조회
    func readingRecordDataManager(_ viewcontroller: ReadingRecordViewController) {
        AF.request(url! + "records/user/\(userId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<[ReadingRecordData]>.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result.result)
                viewcontroller.userReadingRecordSuccessAPI(result.result!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: 독서기록 정렬필터 - 최근 순, 제목 순, 별점 순
    func readingRecordFilterDataManager(_ urlStr: String, _ viewcontroller: ReadingRecordViewController) {
        AF.request(url! + "records/readingRecord/filter/\(urlStr)/\(userId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<[ReadingRecordData]>.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result.result)
                viewcontroller.userReadingRecordFilterSuccessAPI(result.result!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

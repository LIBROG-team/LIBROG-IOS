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
    // MARK: 유저별 독서기록 조회 - 최근 순
    func readingRecordRecentDataManager(_ viewcontroller: ReadingRecordViewController) {
        AF.request(url! + "records/readingRecord/filter/recent/\(userId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<[ReadingRecordData]>.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result.result)
                viewcontroller.userReadingRecordRecentSuccessAPI(result.result!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: 유저별 독서기록 조회 - 제목 순
    func readingRecordTitleDataManager(_ viewcontroller: ReadingRecordViewController) {
        AF.request(url! + "records/readingRecord/filter/title/\(userId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<[ReadingRecordData]>.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result.result)
                viewcontroller.userReadingRecordTitleSuccessAPI(result.result!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: 유저별 독서기록 조회 - 별점 순
    func readingRecordRatingDataManager(_ viewcontroller: ReadingRecordViewController) {
        AF.request(url! + "records/readingRecord/filter/rating/\(userId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<[ReadingRecordData]>.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result.result)
                viewcontroller.userReadingRecordRatingSuccessAPI(result.result!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

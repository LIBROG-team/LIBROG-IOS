//
//  MainPageDataManager.swift
//  LIBROG
//
//  Created by gomin on 2022/07/18.
//


import Alamofire
import Kingfisher
import UIKit

class MainPageDataManager{
    let url = UserDefaults.standard.string(forKey: "url")
    let userId = UserDefaults.standard.integer(forKey: "userId")
    
    //MARK: 메인페이지 화분 조회
    func mainPageFlowerpotDataManager( _ viewcontroller : MainViewController) {
        AF.request(url! + "flowerpots/flowerpotMain/\(userId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<MainPageFlowerpot>.self) { response in
                
            switch response.result {
            case .success(let result):
                if result.isSuccess! {
                    viewcontroller.userFlowerPotSuccessAPI(result.result!)
//                    print("메인페이지 화분 조회: ", result)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: 최근 읽은 책 조회
    func recentBookDataManager(_ viewcontroller : MainBottomViewController) {
        AF.request(url! + "records/bookRecords/\(userId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<[RecentBookModel]>.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result)
                viewcontroller.recentBookSuccessAPI(result.result!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: 공지사항 조회
    func noticeDataManager(_ viewcontroller : MainBottomViewController) {
        AF.request(url! + "contents/notice",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<[NoticeModel]>.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result)
                viewcontroller.noticeSuccessAPI(result.result!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: 추천 책
    func recommendBookDataManager(_ viewcontroller : MainBottomViewController) {
        AF.request(url! + "contents/recommendBooks/",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<[RecommendBookModel]>.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result)
                viewcontroller.recommendBookSuccessAPI(result.result!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

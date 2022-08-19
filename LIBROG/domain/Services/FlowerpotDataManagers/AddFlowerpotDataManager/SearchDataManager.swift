//
//  SearchDataManager.swift
//  LIBROG
//
//  Created by gomin on 2022/07/29.
//

import Foundation
import Alamofire
import Kingfisher

class SearchDataManager {
    let userId = UserDefaults.standard.integer(forKey: "userId")
    // MARK: 획득 화분 검색
    func searchAchievedFlowerpotDataManager(_ word: String, _ viewcontroller: AchievedFlowerPotSearchViewController) {
        let originalURL = "https://dev.siejwkaodj.shop/flowerpots/\(userId)/searchAcqFlower?flowerName=\(word)"
        guard let target = originalURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: target) else {return}

        AF.request(url, method: .get, parameters: nil)
            .validate()
            .responseDecodable(of: AddFlowerpotModel.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result)
                viewcontroller.searchSuccessAPI(result.result!)
            case .failure(let error):
                print(error.localizedDescription)
                viewcontroller.searchFailAPI()
            }
        }
    }
    // MARK: 미획득 화분 검색
    func searchNotAchievedFlowerpotDataManager(_ word: String, _ viewcontroller: NotAchievedFlowerPotSearchViewController) {
        let originalURL = "https://dev.siejwkaodj.shop/flowerpots/\(userId)/searchUnAcqFlower?flowerName=\(word)"
        guard let target = originalURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: target) else {return}

        AF.request(url, method: .get, parameters: nil)
            .validate()
            .responseDecodable(of: NotAchievedSearchFlowerpotModel.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result)
                viewcontroller.searchSuccessAPI(result.result!)
            case .failure(let error):
                print(error.localizedDescription)
                viewcontroller.searchFailAPI()
            }
        }
    }
}

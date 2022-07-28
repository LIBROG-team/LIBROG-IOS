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
    func searchFlowerpotDataManager(_ word: String, _ viewcontroller: AchievedFlowerPotSearchViewController) {
        let originalURL = "https://dev.siejwkaodj.shop/flowerpots/\(userId)/searchAcqFlower?flowerName=\(word)"
        guard let target = originalURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: target) else {return}

        AF.request(url, method: .get, parameters: nil)
            .validate()
            .responseDecodable(of: AddFlowerpotModel.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result)
                viewcontroller.searchSuccessAPI(result.result)
            case .failure(let error):
                print(error.localizedDescription)
                viewcontroller.searchFailAPI()
            }
        }
    }
}

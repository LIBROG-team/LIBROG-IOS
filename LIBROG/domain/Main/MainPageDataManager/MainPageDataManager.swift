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
    func mainPageFlowerpotDataManager(_ userIdx: Int, _ viewcontroller : MainViewController) {
        AF.request("http://www.librog.shop:3000/flowerpots/\(userIdx)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: FlowerpotModel.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result.result[0])
//                viewcontroller.userFlowerPotSuccessAPI(result[0])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

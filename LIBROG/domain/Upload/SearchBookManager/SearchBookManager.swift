//
//  SearchBookManager.swift
//  LIBROG
//
//  Created by gomin on 2022/07/18.
//

import Foundation
import Alamofire
import Kingfisher

class SearchBookManager {
    let header = HeaderMAnager().getHeader()
    func searchBookManager(_ word: String) {
        AF.request("https://dapi.kakao.com/v3/search/book?target=title&query=\(word)",
                   method: .get,
                   parameters: nil,
                   headers: header)
            .validate()
            .responseDecodable(of: BookModel.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result)
//                viewcontroller.userFlowerPotSuccessAPI(result.result[1])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

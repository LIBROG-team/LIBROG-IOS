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
    func searchBookManager(_ word: String, _ page: Int, _ viewcontroller: UploadViewController) {
        let originalURL = "https://dapi.kakao.com/v3/search/book?target=title&size=20&query=\(word)&page=\(page)"
        guard let target = originalURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: target) else {return}

        AF.request(url, method: .get, parameters: nil, headers: header)
            .validate()
            .responseDecodable(of: KakaoBookModel.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", book)
                viewcontroller.kakaoSearchBookSuccessAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

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
        AF.request("https://dapi.kakao.com/v3/search/book?target=title&size=20&query=\(word)&page=\(page)",
                   method: .get,
                   parameters: nil,
                   headers: header)
            .validate()
            .responseDecodable(of: BookModel.self) { response in
                
            switch response.result {
            case .success(let result):
                var book = result.documents
                print("DEBUG: ", book)
                viewcontroller.kakaoSearchBookSuccessAPI(book)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

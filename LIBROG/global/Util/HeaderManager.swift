//
//  HeaderManager.swift
//  LIBROG
//
//  Created by gomin on 2022/07/18.
//

import Foundation
import Alamofire
import Kingfisher

class HeaderMAnager {
    func getHeader() -> HTTPHeaders {
        let KAKAO_REST_API_KEY = UserDefaults.standard.string(forKey: "KAKAO_REST_API_KEY") ?? ""
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK " + KAKAO_REST_API_KEY,
            "Accept": "application/json"
        ]
        return headers
    }
}

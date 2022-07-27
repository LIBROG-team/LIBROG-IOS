//
//  KakaoLoginModel.swift
//  LIBROG
//
//  Created by gomin on 2022/07/27.
//

struct KakaoLoginModel: Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: KakaoLoginResultModel
}
struct KakaoLoginResultModel: Decodable {
    let message: String?
    let eamil: String?
    let name: String?
    let profileImgUrl: String?
    let loginType: String?
}

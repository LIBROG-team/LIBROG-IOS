//
//  LoginModel.swift
//  LIBROG
//
//  Created by gomin on 2022/08/01.
//
//MARK: - 앱 로그인 Model
struct AppLoginModel: Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: AppLoginResultModel
}
struct AppLoginResultModel: Decodable {     //userId 추가되어야함
    let jwt: String?
}
//MARK: - 카카오 로그인 Model
struct KakaoLoginModel: Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: KakaoLoginResultModel
}
struct KakaoLoginResultModel: Decodable {
    let message: String?
    let idx: Int?
    let eamil: String?
    let name: String?
    let profileImgUrl: String?
    let loginType: String?
}

//
//  LoginModel.swift
//  LIBROG
//
//  Created by gomin on 2022/08/01.
//
//MARK: - 앱 로그인 Model
struct AppLoginModel: Decodable {
    let jwt: String?
    let userIdx: Int?
}
//MARK: - 카카오 로그인 Model
struct KakaoLoginModel: Decodable {
    let message: String?
    let idx: Int?
    let eamil: String?
    let name: String?
    let profileImgUrl: String?
    let loginType: String?
}
//MARK: - 애플 로그인 Model
struct AppleLoginModel: Decodable {
    let message: String?
    let idx: Int?
    let eamil: String?
    let name: String?
    let profileImgUrl: String?
    let loginType: String?
}

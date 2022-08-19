//
//  LoginInput.swift
//  LIBROG
//
//  Created by gomin on 2022/08/01.
//

//MARK: - 앱 로그인 input
struct AppLoginInput: Encodable {
    let email: String?
    let password: String?
}
//MARK: - 카카오 로그인 Input
struct KakaoLoginInput: Encodable {
    let accessToken: String?
}
//MARK: - 애플 로그인 Input
struct AppleLoginInput: Encodable {
    let code: String?
}

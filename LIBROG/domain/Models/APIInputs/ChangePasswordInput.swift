//
//  ChangePasswordInput.swift
//  LIBROG
//
//  Created by gomin on 2022/08/19.
//

struct ChangePasswordInput: Encodable {
    let userIdx: Int?
    let oldPassword: String?
    let newPassword: String?
}

//
//  ChangePasswordModel.swift
//  LIBROG
//
//  Created by gomin on 2022/08/19.
//

struct ChangePasswordModel: Decodable {
    let userIdx: Int?
    let newPassword: String?
}

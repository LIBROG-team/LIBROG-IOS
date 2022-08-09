//
//  RegisterInput.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/28.
//

import Foundation

struct RegisterInput: Encodable {
    let email: String?
    let password: String?
    let name: String?
    let profileImgUrl: String?  // 임시
    let introduction: String?
}

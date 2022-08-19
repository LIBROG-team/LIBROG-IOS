//
//  ModifyProfileInput.swift
//  LIBROG
//
//  Created by gomin on 2022/08/15.
//

struct ModifyProfileInput: Encodable {
    let idx: Int?
    let name: String?
    let introduction: String?
    let profileImg: String?
}

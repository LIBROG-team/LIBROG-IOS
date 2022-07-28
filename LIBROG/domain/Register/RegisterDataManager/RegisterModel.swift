//
//  RegisterModel.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/28.
//

import Foundation

struct RegisterModel: Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
}

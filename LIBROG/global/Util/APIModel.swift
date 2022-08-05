//
//  APIModel.swift
//  LIBROG
//
//  Created by gomin on 2022/08/06.
//

struct APIModel<T: Decodable>: Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: T?
}
struct ResultModel: Decodable {
    
}

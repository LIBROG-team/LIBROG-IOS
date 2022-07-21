//
//  FlowerpotDescriptionModel.swift
//  LIBROG
//
//  Created by gomin on 2022/07/21.
//

struct FlowerpotDescriptionModel: Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [FlowerpotDescriptionData]
}
struct FlowerpotDescriptionData : Decodable {
    let flowerDataIdx: Int?
    let name: String?
    let engName: String?
    let content: String?
    let flowerImgUrl: String?
}

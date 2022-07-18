//
//  FlowerpotModel.swift
//  LIBROG
//
//  Created by gomin on 2022/07/18.
//

struct FlowerpotModel : Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [FlowerpotData]
}
struct FlowerpotData: Decodable {
    let flowerDataIdx: Int?
    let flowerPotIdx: Int?
    let name: String?
    let engName: String?
    let flowerImgUrl: String?
    let maxExp: Int?
    let bloomingPeriod: String?
    let content: String?
    let type: String?
    let startDate: String?
    let lastDate: String?
    let exp: Int?
    let recordCount: Int?
}

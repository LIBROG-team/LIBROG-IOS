//
//  AddFlowerpotModel.swift
//  LIBROG
//
//  Created by gomin on 2022/07/21.
//

import Foundation

struct AddFlowerpotModel : Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [AddFlowerpotData]
}
struct AddFlowerpotData: Decodable {
    let flowerDataIdx: Int?
    let name: String?
    let type: String?
    let bloomingPeriod: String?
    let flowerImgUrl: String?
}
struct NotAchievedSearchFlowerpotModel : Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [NotAchievedSearchFlowerpotData]
}
struct NotAchievedSearchFlowerpotData: Decodable {
    let flowerDataIdx: Int?
    let name: String?
    let type: String?
    let bloomingPeriod: String?
    let condition: String?
}

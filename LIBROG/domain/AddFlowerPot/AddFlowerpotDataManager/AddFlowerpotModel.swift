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
    let idx: Int?
    let name: String?
    let engName: String?
    let type: String?
    let bloomingPeriod: String?
    let content: String?
    let flowerImgUrl: String?
}

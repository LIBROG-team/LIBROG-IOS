//
//  FlowerpotBookRecordModel.swift
//  LIBROG
//
//  Created by gomin on 2022/07/20.
//

struct FlowerpotBookRecordModel: Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [FlowerpotBookRecordData]
}

struct FlowerpotBookRecordData: Decodable {
    let idx: Int?
    let bookIdx: Int?
    let flowerPotIdx: Int?
    let userIdx: Int?
    let date: String?
    let starRating: Int?
    let content: String?
    let quote: String?
    let status: String?
    let imgUrl: String?
}

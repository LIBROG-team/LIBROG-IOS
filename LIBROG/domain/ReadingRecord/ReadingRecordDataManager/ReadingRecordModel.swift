//
//  ReadingRecordModel.swift
//  LIBROG
//
//  Created by gomin on 2022/07/20.
//

struct ReadingRecordModel: Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [ReadingRecordData]
}
struct ReadingRecordData: Decodable {
    let idx:  Int?
    let bookIdx: Int?
    let flowerPotIdx: Int?
//    let userIdx: Int?
    let date: String?
    let starRating: Int?
    let content: String?
    let quote: String?
    let status: String?
    let bookImgUrl: String?
}

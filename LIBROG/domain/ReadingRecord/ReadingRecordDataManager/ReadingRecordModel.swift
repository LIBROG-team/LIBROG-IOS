//
//  ReadingRecordModel.swift
//  LIBROG
//
//  Created by gomin on 2022/07/20.
//

struct ReadingRecordData: Decodable {
    let readingRecordIdx:  Int?
    let bookIdx: Int?
    let flowerPotIdx: Int?
    let date: String?
    let starRating: Int?
    let status: String?
    let bookImgUrl: String?
}

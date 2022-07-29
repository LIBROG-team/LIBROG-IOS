//
//  RecordDetailModel.swift
//  LIBROG
//
//  Created by gomin on 2022/07/30.
//

import Foundation

struct RecordDetailModel : Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: RecordDetailResultModel
}
struct RecordDetailResultModel: Decodable {
    let readingRecordIdx: Int?
    let bookImgUrl: String?
    let name: String?
    let author: [String]
    let bookInstruction: String?
    let starRating: Int?
    let quote: String?
    let content: String?
}

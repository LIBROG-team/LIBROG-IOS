//
//  UploadRecordModel.swift
//  LIBROG
//
//  Created by gomin on 2022/07/26.
//

struct UploadRecordInput: Encodable {
    let bookName: String?
    let authorArr: [String]
    let publisher: String?
    let publishedDate: String?
    let bookInstruction: String?
    let bookImgUrl: String?
    let userIdx: Int?
    let starRating: Int?
    let quote: String?
    let content: String?
}

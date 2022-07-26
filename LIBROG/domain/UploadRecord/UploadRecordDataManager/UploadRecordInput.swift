//
//  UploadRecordModel.swift
//  LIBROG
//
//  Created by gomin on 2022/07/26.
//

struct UploadRecordInput: Encodable {
    let bookName: String?
    let author: String? //author 배열로 바꿔야함
    let publisher: String?
    let publishedDate: String?
    let userIdx: Int?
    let flowerPotIdx: Int?
    let starRating: Int?
    let quote: String?
    let content: String?
}

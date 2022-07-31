//
//  RecentBookModel.swift
//  LIBROG
//
//  Created by gomin on 2022/07/30.
//

struct RecentBookModel: Decodable {
    let userIdx: Int?
    let readingRecordIdx: Int?
    let bookName: String?
    let author: [String]?
    let publishedDate: String?
    let bookImgUrl: String?
    let recordedDate: String?
}

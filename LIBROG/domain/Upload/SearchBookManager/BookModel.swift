//
//  BookModel.swift
//  LIBROG
//
//  Created by gomin on 2022/07/18.
//

struct BookModel: Decodable {
//    let meta: [metaModel]
    let documents: [BookDetailModel]
}

struct metaModel: Decodable {
    let is_end: Bool?
    let pageable_count: Int?
    let total_count: Int?
}

struct BookDetailModel: Decodable {
    let authors: [String]
    let contents: String?
    let datetime: String?
    let isbn: String?
    let price: Int?
    let publisher: String?
    let sale_price: Int?
    let status: String?
    let thumbnail: String?
    let title: String?
    let translators: [String]
    let url: String?
}

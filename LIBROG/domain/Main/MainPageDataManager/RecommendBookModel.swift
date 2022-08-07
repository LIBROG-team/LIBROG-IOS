//
//  RecommendBookModel.swift
//  LIBROG
//
//  Created by gomin on 2022/08/07.
//

struct RecommendBookModel: Decodable {
    let idx: Int?
    let title: String?
    let name: String?
    let author: String?
    let publisher: String?
    let bookCoverImg: String?
    let connectUrl: String?
}

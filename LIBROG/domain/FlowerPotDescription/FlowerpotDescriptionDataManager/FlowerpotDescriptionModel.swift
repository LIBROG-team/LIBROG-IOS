//
//  FlowerpotDescriptionModel.swift
//  LIBROG
//
//  Created by gomin on 2022/07/21.
//

// MARK: 화분 상세 조회
struct FlowerpotDescriptionData : Decodable {
    let flowerDataIdx: Int?
    let name: String?
    let engName: String?
    let content: String?
    let flowerImgUrl: String?
}

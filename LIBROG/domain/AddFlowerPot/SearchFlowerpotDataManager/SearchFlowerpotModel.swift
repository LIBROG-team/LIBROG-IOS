//
//  SearchFlowerpotModel.swift
//  LIBROG
//
//  Created by gomin on 2022/07/29.
//

struct SearchFlowerpotModel: Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [SearchFlowerpotResultModel]
}
struct SearchFlowerpotResultModel: Decodable {
    let flowerDataIdx: Int?
    let name: String?
    let type: String?
    let bloomingPeriod: String?
    let flowerImgUrl: String?
}
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

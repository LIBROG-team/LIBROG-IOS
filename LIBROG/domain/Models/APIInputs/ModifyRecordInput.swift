//
//  ModifyRecordInput.swift
//  LIBROG
//
//  Created by gomin on 2022/07/28.
//

struct ModifyRecordInput: Encodable {
    let idx: Int?
    let starRating: Int?
    let quote: String?
    let content: String?
}

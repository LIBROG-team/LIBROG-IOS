//
//  UploadRecordModel.swift
//  LIBROG
//
//  Created by gomin on 2022/07/26.
//

struct UploadRecordModel: Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [UploadRecordResultModel]
}
struct UploadRecordResultModel : Decodable {
    let createdRecordId: Int?
}

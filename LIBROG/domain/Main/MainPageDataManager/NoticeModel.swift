//
//  NoticeModel.swift
//  LIBROG
//
//  Created by gomin on 2022/08/03.
//

struct NoticeModel : Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [NoticeResultModel]
}
struct NoticeResultModel: Decodable {
    let idx: Int?
    let title: String?
    let author: String?
    let connectUrl: String?
    let noticeImgUrl: String?
}

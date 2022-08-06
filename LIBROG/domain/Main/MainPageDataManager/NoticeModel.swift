//
//  NoticeModel.swift
//  LIBROG
//
//  Created by gomin on 2022/08/03.
//

struct NoticeModel: Decodable {
    let idx: Int?
    let title: String?
    let author: String?
    let connectUrl: String?
    let noticeImgUrl: String?
}

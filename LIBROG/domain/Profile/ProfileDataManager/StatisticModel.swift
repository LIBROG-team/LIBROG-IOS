//
//  StatisticModel.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/26.
//

import Foundation

struct StatisticModel : Decodable {
    let userIdx: Int?
    let flowerCnt: Int?
    let readingCnt: Int?
    let starRatingCnt: Int?
    let quoteCnt: Int?
    let contentCnt: Int?
}

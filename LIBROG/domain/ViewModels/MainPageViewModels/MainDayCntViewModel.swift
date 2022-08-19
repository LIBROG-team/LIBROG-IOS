//
//  MainDayCntViewModel.swift
//  LIBROG
//
//  Created by gomin on 2022/08/19.
//

import Foundation

struct MainDayCntViewModel {
    let cntAndContent: MainPageDayCountModel
}

extension MainDayCntViewModel {
    init(_ cntAndContent: MainPageDayCountModel) {
        self.cntAndContent = cntAndContent
    }
}

extension MainDayCntViewModel {
    var dayCnt: Int? {
        return self.cntAndContent.daycnt
    }
    var mainMessage: String? {
        return self.cntAndContent.content
    }
}

//
//  MainFlowerpotViewModel.swift
//  LIBROG
//
//  Created by gomin on 2022/08/19.
//

import Foundation

struct MainFlowerpotViewModel {
    let flowerpotData: MainPageFlowerpot
}

extension MainFlowerpotViewModel {
    var numberOfSections: Int {
        return 1
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        return 1
    }
    
//    func flowerpotAtIndex(_ index: Int) -> MainFlowerpotViewModel {
//        let flowerpotData = self.flowerpotData
//        return MainFlowerpotViewModel(flowerpotData)
//    }
}

extension MainFlowerpotViewModel {
    init(_ flowerpotData: MainPageFlowerpot) {
        self.flowerpotData = flowerpotData
    }
}

extension MainFlowerpotViewModel {
    var name: String? {
        return self.flowerpotData.name
    }
    var flowerImgUrl: String? {
        return self.flowerpotData.flowerImgUrl
    }
    var backgroundColor: String? {
        return self.flowerpotData.backgroundColor
    }
}

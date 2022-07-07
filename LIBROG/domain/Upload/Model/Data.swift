//
//  Data.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/07.
//

import Foundation

class Data{
    var main:String
    var detail:detailtype
    
    
    init(main: String, detail: detailtype) {
        self.main = main
        self.detail = detail
    }
}

enum detailtype:String {
    case A = "A"
    case B = "B"
}

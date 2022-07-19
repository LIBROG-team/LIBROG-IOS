//
//  Data.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/07.
//

import Foundation

class BookData{
    var bookTitle: String
    var thumbnailURL: String
    var author: [String]
    var contents: String
    
    
    init(bookTitle: String, thumbnailURL: String, author: [String], contents: String) {
        self.bookTitle = bookTitle
        self.thumbnailURL = thumbnailURL
        self.author = author
        self.contents = contents
    }
}

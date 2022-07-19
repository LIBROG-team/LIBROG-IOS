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
    var bookDescription: String
    
    
    init(bookTitle: String, thumbnailURL: String, author: [String], var bookDescription: String) {
        self.bookTitle = bookTitle
        self.thumbnailURL = thumbnailURL
        self.author = author
        self.bookDescription = bookDescription
    }
}

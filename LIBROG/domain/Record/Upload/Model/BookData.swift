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
    var introduction: String
    var publisher: String
    var publishedDate: String
    
    
    init(bookTitle: String, thumbnailURL: String, author: [String], introduction: String, publisher: String, publishedDate: String) {
        self.bookTitle = bookTitle
        self.thumbnailURL = thumbnailURL
        self.author = author
        self.introduction = introduction
        self.publisher = publisher
        self.publishedDate = publishedDate
    }
}

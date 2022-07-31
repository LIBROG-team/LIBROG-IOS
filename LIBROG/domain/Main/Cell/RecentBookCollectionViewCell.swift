//
//  RecentBookCollectionViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/07/01.
//

import UIKit

class RecentBookCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecentBookCollectionViewCell"
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setRecentBookData(_ bookData: RecentBookModel) {
        guard let title = bookData.bookName else {return}
        guard let author = bookData.author else {return}
        guard let date = bookData.recordedDate else {return}
        guard let bookImg = bookData.bookImgUrl else {return}
        
        bookTitleLabel.text = title
        authorLabel.text = String(author.joined(separator: " ") )
        dateLabel.text = String(date.split(separator: "T")[0])
        // 최근 읽은 책 이미지 출력
        if let url = URL(string: bookImg) {
            bookImageView.kf.setImage(with: url, placeholder: UIImage(named: "logo22%"))
        }
    }
}

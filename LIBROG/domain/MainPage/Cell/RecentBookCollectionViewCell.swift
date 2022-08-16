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
    // MARK: 테이블뷰의 셀이 재사용되기 전 호출되는 함수
    // 여기서 property들을 초기화해준다.
    override func prepareForReuse() {
        super.prepareForReuse()

        bookTitleLabel.text = nil
        authorLabel.text = nil
        dateLabel.text = nil
        bookImageView.image = UIImage()
    }
    func setRecentBookData(_ bookData: RecentBookModel) {
        if let title = bookData.bookName { bookTitleLabel.text = title }
        if let author = bookData.author { authorLabel.text = String(author.joined(separator: " ") ) }
        if let date = bookData.recordedDate { dateLabel.text = String(date.split(separator: "T")[0]) }
        if let bookImg = bookData.bookImgUrl {
            bookImageView.kf.setImage(with: URL(string: bookImg), placeholder: UIImage(named: "logo_launchScreen_white"))
        }
    }
}

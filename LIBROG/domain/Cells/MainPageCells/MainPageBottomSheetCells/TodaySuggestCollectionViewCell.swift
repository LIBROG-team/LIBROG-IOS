//
//  TodaySuggestCollectionViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/07/15.
//

import UIKit

class TodaySuggestCollectionViewCell: UICollectionViewCell {
    static let identifier = "TodaySuggestCollectionViewCell"
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setRecommendBook(_ result: RecommendBookModel) {
        guard let title = result.name else {return}
        guard let author = result.author else {return}
        guard let publisher = result.publisher else {return}
        guard let bookImg = result.bookCoverImg else {return}
        
        bookTitleLabel.text = title
        authorLabel.text = author
        publisherLabel.text = publisher
        // 최근 읽은 책 이미지 출력
        if let url = URL(string: bookImg) {
            bookImageView.kf.setImage(with: url, placeholder: UIImage(named: "logo_launchScreen_white"))
        }
    }
}

//
//  ResultTableViewCell.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/12.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookExplanationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func kakaoBookData(_ bookData: BookData) {
        bookTitleLabel.text = bookData.bookTitle
        authorLabel.text = String(bookData.author.joined(separator: " ") )
        bookExplanationLabel.text = bookData.introduction
        let thumbnailURL = bookData.thumbnailURL
        if let url = URL(string: thumbnailURL) {
            bookImageView.kf.setImage(with: url, placeholder: UIImage(named: "logo22%"))
        }
    }
}

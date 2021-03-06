//
//  UplodaRecordTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/07/09.
//

import UIKit
import Cosmos

class UplodaRecordTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var bookPointLabel: UILabel!
    @IBOutlet weak var bookPointView: CosmosView!
    @IBOutlet weak var quoteTextField: UITextField!
    @IBOutlet weak var bookReportTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 별점 초기 설정
        bookPointView.rating = 4
        bookPointLabel.text = "4"
        bookPointView.didTouchCosmos = didTouchCosmos
    }

    func setBookData(_ bookData: BookData) {
        bookTitleLabel.text = bookData.bookTitle
        authorLabel.text = String(bookData.author.joined(separator: " ") )
        explanationLabel.text = bookData.contents
        let thumbnailURL = bookData.thumbnailURL
        
        if let url = URL(string: thumbnailURL) {
            bookImageView.kf.setImage(with: url, placeholder: UIImage(named: "logo22%"))
        }
    }
    
    func updateRating(_ requiredRating: Double?) {
        var newRatingValue : Double = 0.0
        
        if let nonEmptyRequiredRating = requiredRating {
            newRatingValue = nonEmptyRequiredRating
        }
        bookPointView.rating = newRatingValue
        bookPointLabel.text = String(Int(newRatingValue))
    }

    func didTouchCosmos(_ rating: Double) {
        updateRating(rating)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

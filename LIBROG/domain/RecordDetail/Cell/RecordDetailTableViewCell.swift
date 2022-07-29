//
//  RecordDetailTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/07/26.
//

import UIKit
import Cosmos

class RecordDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookImgView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookExplanationLabel: UILabel!
    @IBOutlet weak var starRatingLabel: UILabel!
    @IBOutlet weak var starRatingView: CosmosView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var reportTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setRecordData(_ recordData: ReadingRecordData) {
        
        bookTitleLabel.text = ""
//        authorLabel.text = String(recordData..joined(separator: " ") )
//        bookExplanationLabel.text = recordData.content!
        guard let thumbnailURL = recordData.bookImgUrl else {return}
        if let url = URL(string: thumbnailURL) {
            bookImgView.kf.setImage(with: url, placeholder: UIImage(named: "logo22%"))
        }
        starRatingLabel.text = String(recordData.starRating!)
        starRatingView.rating = Double(recordData.starRating!)
        
//        quoteLabel.text = quote
//        reportTextView.text = content
    }
}

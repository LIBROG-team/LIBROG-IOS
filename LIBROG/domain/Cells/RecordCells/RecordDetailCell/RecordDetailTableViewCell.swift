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
    func setRecordData(_ recordData: RecordDetailModel) {
        if let title = recordData.name {bookTitleLabel.text = title}
        if let author = recordData.author {authorLabel.text = String(author.joined(separator: " ") )}
        if let instruction = recordData.bookInstruction {bookExplanationLabel.text = instruction}
        if let star = recordData.starRating {
            starRatingLabel.text = String(star)
            starRatingView.rating = Double(star)
        }
        if let quote = recordData.quote {quoteLabel.text = quote}
        if let content = recordData.content {reportTextView.text = content}
        if let thumbnailURL = recordData.bookImgUrl {
            bookImgView.kf.setImage(with: URL(string: thumbnailURL), placeholder: UIImage(named: "logo22%"))
        }
    }
}

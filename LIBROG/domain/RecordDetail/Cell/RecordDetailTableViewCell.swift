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
    func setRecordData(_ recordData: RecordDetailResultModel) {
        guard let title = recordData.name else {return}
        let author = recordData.author
        guard let instruction = recordData.bookInstruction else {return}
        guard let start = recordData.starRating else {return}
        guard let quote = recordData.quote else {return}
        guard let content = recordData.content else {return}
        guard let thumbnailURL = recordData.bookImgUrl else {return}
        
        bookTitleLabel.text = title
        authorLabel.text = String(author.joined(separator: " ") )
        bookExplanationLabel.text = instruction
        starRatingLabel.text = String(recordData.starRating!)
        starRatingView.rating = Double(recordData.starRating!)
        quoteLabel.text = quote
        reportTextView.text = content
        if let url = URL(string: thumbnailURL) {
            bookImgView.kf.setImage(with: url, placeholder: UIImage(named: "logo22%"))
        }
    }
}

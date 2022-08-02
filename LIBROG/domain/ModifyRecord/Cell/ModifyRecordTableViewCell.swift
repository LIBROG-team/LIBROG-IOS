//
//  ModifyRecordTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/07/26.
//

import UIKit
import Cosmos

class ModifyRecordTableViewCell: UITableViewCell {
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookImgView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookExplanationLabel: UILabel!
    @IBOutlet weak var starRatingLabel: UILabel!
    @IBOutlet weak var starRatingView: CosmosView!
    @IBOutlet weak var quoteTextField: UITextField!
    @IBOutlet weak var reportTextView: UITextView!
    
    var starRating: Int!
    var quote: String!
    var content: String!
    var isEdited: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        reportTextView.delegate = self
        starRatingView.didTouchCosmos = didTouchCosmos
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setRecordData(_ recordData: RecordDetailResultModel) {
        guard let title = recordData.name else {return}
        guard let author = recordData.author else {return}
        guard let instruction = recordData.bookInstruction else {return}
        guard let star = recordData.starRating else {return}
        guard let quote = recordData.quote else {return}
        guard let content = recordData.content else {return}
        guard let thumbnailURL = recordData.bookImgUrl else {return}
        
        bookTitleLabel.text = title
        authorLabel.text = String(author.joined(separator: " ") )
        bookExplanationLabel.text = instruction
        starRatingLabel.text = String(star)
        starRatingView.rating = Double(star)
        quoteTextField.text = quote
        reportTextView.text = content
        if let url = URL(string: thumbnailURL) {
            bookImgView.kf.setImage(with: url, placeholder: UIImage(named: "logo22%"))
        }
        
        self.starRating = star
        self.quote = quote
        self.content = content
    }
    // 별점 수정 method
    func updateRating(_ requiredRating: Double?) {
        var newRatingValue : Double = 0.0
        
        if let nonEmptyRequiredRating = requiredRating {
            newRatingValue = nonEmptyRequiredRating
        }
        starRatingView.rating = newRatingValue
        self.starRating = Int(newRatingValue)
        isEdited = true
        starRatingLabel.text = String(Int(newRatingValue))
    }

    func didTouchCosmos(_ rating: Double) {
        updateRating(rating)
    }
    // MARK: Actions
    @IBAction func quoteEditingChanged(_ sender: UITextField) {
        self.quote = sender.text!
//        print("quote...", self.quote)
        isEdited = true
    }
}
// MARK: - 독후감 TextView delegate
extension ModifyRecordTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.content = textView.text!
//        print("content...", self.content)
        isEdited = true
    }
}
//MARK: - 수정 버튼 클릭 func & success API
extension ModifyRecordTableViewCell {
    func postRecord(_ recordData: RecordDetailResultModel) {
        let idx = recordData.readingRecordIdx!
        
//        print("star...", self.starRating)
//        print("quote...", self.quote)
//        print("content...", self.content)
        
        if isEdited == true {
            starRating = self.starRating!
            quote = self.quote!
            content = self.content!
            
            let modifyRecordInput = ModifyRecordInput(idx: idx, starRating: starRating, quote: quote, content: content)
            ModifyRecordDataManager().modifyRecordDataManager(modifyRecordInput, self)
        } else {
            print("수정 해주세요")
        }
    }
    func modifyRecordSuccessAPI(_ result: ModifyRecordModel) {
        print("MODIFY SUCCESS: ", result)
    }
}

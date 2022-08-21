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
        // 인상 깊은 한 줄 폰트 및 크기 설정
        quoteTextField.font = UIFont(name: "Apple SD Gothic Neo", size: 14)
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
            self.starRating = star
        }
        if let quote = recordData.quote {
            quoteTextField.text = quote
            self.quote = quote
        }
        if let content = recordData.content {
            reportTextView.text = content
            self.content = content
        }
        if let thumbnailURL = recordData.bookImgUrl {
            bookImgView.kf.setImage(with: URL(string: thumbnailURL), placeholder: UIImage(named: "logo22%"))
        }
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
    func postRecord(_ recordData: RecordDetailModel, _ viewcontroller: ModifyRecordViewController) {
        let idx = recordData.readingRecordIdx!
        
        if isEdited == true {
            starRating = self.starRating!
            quote = self.quote!
            content = self.content!
            
            let modifyRecordInput = ModifyRecordInput(idx: idx, starRating: starRating, quote: quote, content: content)
            ModifyRecordDataManager().modifyRecordDataManager(modifyRecordInput, viewcontroller)
        } else {
            DialogManager().alertErrorDialog("수정을 해주세요.", viewcontroller)
        }
    }
}

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        reportTextView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setRecordData(_ recordData: ReadingRecordData) {
//        guard let quote = recordData.quote else {return}
//        guard let content = recordData.content else {return}
//        bookTitleLabel.text = ""
//        authorLabel.text = String(bookData.author.joined(separator: " ") )
//        bookExplanationLabel.text = bookData.introduction
//        let thumbnailURL = bookData.thumbnailURL
//        if let url = URL(string: thumbnailURL) {
//            bookImgView.kf.setImage(with: url, placeholder: UIImage(named: "logo22%"))
//        }
        starRatingLabel.text = String(recordData.starRating!)
        starRatingView.rating = Double(recordData.starRating!)
        
        quoteTextField.text = quote
        reportTextView.text = content
    }
    
    @IBAction func quoteEditingChanged(_ sender: UITextField) {
        self.quote = sender.text!
    }
}
// MARK: - 독후감 TextView delegate
extension ModifyRecordTableViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.content = textView.text!
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.content = textView.text!
    }
}
//MARK: - 수정 버튼 클릭 func & success API
extension ModifyRecordTableViewCell {
    func postRecord(_ recordData: ReadingRecordData) {
        let idx = recordData.bookIdx!
        let starRating = Int(self.starRatingView.rating)
        let modifyRecordInput = ModifyRecordInput(idx: idx, starRating: starRating, quote: self.quote, content: self.content)
        ModifyRecordDataManager().modifyRecordDataManager(modifyRecordInput, self)
    }
    func modifyRecordSuccessAPI(_ result: ModifyRecordModel) {
        print("MODIFY SUCCESS: ", result)
    }
}

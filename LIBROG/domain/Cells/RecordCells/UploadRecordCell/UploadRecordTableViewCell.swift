//
//  UplodaRecordTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/07/09.
//

import UIKit
import Cosmos

class UploadRecordTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var bookPointLabel: UILabel!
    @IBOutlet weak var bookPointView: CosmosView!
    @IBOutlet weak var quoteTextField: UITextField!
    @IBOutlet weak var bookReportTextView: UITextView!
    
    let textViewPlaceHolder = "독후감을 입력하세요"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 별점 초기 설정
        bookPointView.rating = 5
        bookPointLabel.text = "5"
        bookPointView.didTouchCosmos = didTouchCosmos
        // 인상 깊은 한 줄 폰트 및 크기 설정
        quoteTextField.font = UIFont(name: "Apple SD Gothic Neo", size: 14)
        // 독후감 TextView
        bookReportTextView.font = UIFont(name: "Apple SD Gothic Neo", size: 14)
        bookReportTextView.text = textViewPlaceHolder
        bookReportTextView.textColor = .placeholderText
        bookReportTextView.delegate = self
    }

    func setBookData(_ bookData: BookData) {
        bookTitleLabel.text = bookData.bookTitle
        authorLabel.text = String(bookData.author.joined(separator: " ") )
        explanationLabel.text = bookData.introduction
        let thumbnailURL = bookData.thumbnailURL
        
        if let url = URL(string: thumbnailURL) {
            bookImageView.kf.setImage(with: url, placeholder: UIImage(named: "logo22%"))
        }
        
//        print(explanationLabel.countCurrentLines())
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
// MARK: - 독후감 TextView delegate
extension UploadRecordTableViewCell : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .placeholderText
        }
    }
}
// MARK: - 기록 추가 api 호출
extension UploadRecordTableViewCell {
    func postRecord(_ bookData: BookData, _ viewcontroller: UploadRecordViewController) {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let starRating = Int(self.bookPointView.rating)
        let quote = quoteTextField.text!
        let content = bookReportTextView.text!
        
        let uploadRecordInput = UploadRecordInput(bookName: bookData.bookTitle, authorArr: bookData.author, publisher: bookData.publisher, publishedDate: bookData.publishedDate, bookInstruction: bookData.introduction, bookImgUrl: bookData.thumbnailURL, userIdx: userId, starRating: starRating, quote: quote, content: content)
        UploadRecordDataManager().uploadRecordDataManager(uploadRecordInput, viewcontroller)
    }
//    func uploadRecordSuccessAPI(_ result: APIModel<UploadRecordModel>) {
//        if !(result.isSuccess!) {
//            
//        }
//    }
}

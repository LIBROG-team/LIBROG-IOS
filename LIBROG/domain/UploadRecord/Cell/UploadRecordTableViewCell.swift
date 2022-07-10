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
    @IBOutlet weak var impressiveLineTextField: UITextField!
    @IBOutlet weak var bookReportTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 별점 초기 설정
        bookPointView.rating = 4
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

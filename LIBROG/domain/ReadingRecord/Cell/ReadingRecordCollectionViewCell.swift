//
//  BookRecordCollectionViewCell.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/19.
//

import UIKit

class ReadingRecordCollectionViewCell: UICollectionViewCell {
    static let identifier = "ReadingRecordCollectionViewCell"
    
    @IBOutlet weak var imageBook: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setBookImg(_ imgURL: String) {
        if let url = URL(string: imgURL) {
            imageBook.kf.setImage(with: url, placeholder: UIImage(named: "logo_launchScreen_white"))
        }
    }
}

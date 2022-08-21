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
    // MARK: 테이블뷰의 셀이 재사용되기 전 호출되는 함수
    // 여기서 property들을 초기화해준다.
    override func prepareForReuse() {
        super.prepareForReuse()

        imageBook.image = UIImage()
    }
    func setBookImg(_ imgURL: String) {
        if let url = URL(string: imgURL) {
            imageBook.kf.setImage(with: url, placeholder: UIImage(named: "logo_launchScreen_white"))
        }
    }
}

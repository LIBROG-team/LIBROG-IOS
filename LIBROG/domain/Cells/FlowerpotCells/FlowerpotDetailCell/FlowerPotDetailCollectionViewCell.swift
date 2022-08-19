//
//  FlowerPotDetailCollectionViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/07/12.
//

import UIKit

class FlowerPotDetailCollectionViewCell: UICollectionViewCell {
    static let identifier = "FlowerPotDetailCollectionViewCell"
    
    @IBOutlet weak var bookImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // MARK: 테이블뷰의 셀이 재사용되기 전 호출되는 함수
    // 여기서 property들을 초기화해준다.
    override func prepareForReuse() {
        super.prepareForReuse()

        bookImageView.image = UIImage()
    }
    func setBookImg(_ imgURL: String) {
        if let url = URL(string: imgURL) {
            bookImageView.kf.setImage(with: url, placeholder: UIImage(named: "logo_launchScreen_white"))
        }
    }
}

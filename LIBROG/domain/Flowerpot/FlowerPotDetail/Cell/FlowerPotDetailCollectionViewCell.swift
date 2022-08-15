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
    func setBookImg(_ imgURL: String) {
        if let url = URL(string: imgURL) {
            bookImageView.kf.setImage(with: url, placeholder: UIImage(named: "logo_launchScreen_white"))
        }
    }
}

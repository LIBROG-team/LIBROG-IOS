//
//  ProfileLoginTypeTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/08/01.
//

import UIKit

class ProfileLoginTypeTableViewCell: UITableViewCell {
    @IBOutlet weak var kakaoLoginTypeButton: UIButton!
    @IBOutlet weak var appleLoginTypeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        kakaoLoginTypeButton.imageView?.tintColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

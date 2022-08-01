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
    func setLoginType(_ data: IntroModel) {
        let type = data.type
        
        var config = UIButton.Configuration.plain()
        var attText = AttributedString.init("연결완료")
        attText.font = UIFont.systemFont(ofSize: 10.0, weight: .regular)
        attText.foregroundColor = UIColor(named: "LIBROGColor")
        config.attributedTitle = attText
        if type == "kakao" {
            config.image = UIImage.init(named: "kakaoLoginButton")
            config.imagePlacement = .top
            config.imagePadding = 8
            kakaoLoginTypeButton.configuration = config
        } else if type == "apple" {
            config.image = UIImage.init(named: "appleid_button")
            config.imagePlacement = .top
            config.imagePadding = 8
            appleLoginTypeButton.configuration = config
        }
    }
}

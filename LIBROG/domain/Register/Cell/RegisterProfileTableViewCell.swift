//
//  RegisterProfileTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/08/13.
//

import UIKit

class RegisterProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var introTextField: UITextField!
    var nickName: String!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 리브로그 시작하기 버튼 Custom
        registerButton.layer.borderColor = UIColor(named: "LIBROGColor")?.cgColor
        registerButton.layer.borderWidth = 1
        registerButton.layer.cornerRadius = 20
        registerButton.tintColor = UIColor(named: "LIBROGColor")
        
        userNameLabel.text = nickName
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: - Actions
}

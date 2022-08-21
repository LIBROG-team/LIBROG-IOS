//
//  ChangePasswordTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/08/19.
//

import UIKit

class ChangePasswordTableViewCell: UITableViewCell {
    @IBOutlet weak var changePasswordTitleLabel: UILabel!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var completeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 완료 버튼 Custom
        completeButton.layer.borderColor = UIColor(named: "LIBROGColor")?.cgColor
        completeButton.layer.borderWidth = 1
        completeButton.layer.cornerRadius = 20
        completeButton.tintColor = UIColor(named: "LIBROGColor")
        // '변경하실 비밀번호' 색깔 바꾸기
        guard let text = self.changePasswordTitleLabel.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor(named: "LIBROGColor"), range: (text as NSString).range(of: "변경하실 비밀번호"))
        self.changePasswordTitleLabel.attributedText = attributeString
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

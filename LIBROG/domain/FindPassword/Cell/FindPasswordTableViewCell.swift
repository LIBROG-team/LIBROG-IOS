//
//  FindPasswordTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/08/13.
//

import UIKit

class FindPasswordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var findPasswordTitleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendEmailButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 이메일 전송 버튼 Custom
        sendEmailButton.layer.borderColor = UIColor(named: "LIBROGColor")?.cgColor
        sendEmailButton.layer.borderWidth = 1
        sendEmailButton.layer.cornerRadius = 20
        sendEmailButton.tintColor = UIColor(named: "LIBROGColor")
        // '이메일' 색깔 바꾸기
        guard let text = self.findPasswordTitleLabel.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor(named: "LIBROGColor"), range: (text as NSString).range(of: "이메일"))
        self.findPasswordTitleLabel.attributedText = attributeString
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

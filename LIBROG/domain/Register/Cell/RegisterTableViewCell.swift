//
//  RegisterTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/08/13.
//

import UIKit

class RegisterTableViewCell: UITableViewCell {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailUnderlineView: UIView!
    @IBOutlet weak var pwUnderlineView: UIView!
    @IBOutlet weak var nicknameUnderlineView: UIView!
    @IBOutlet weak var emailWarningLabel: UILabel!
    @IBOutlet weak var pwWarningLabel: UILabel!
    @IBOutlet weak var nicknameWarningLabel: UILabel!
    
    var isValidEmail: Bool = false
    var isValidPw: Bool = false
    var isValidName: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 다음 버튼 Custom
        nextButton.layer.borderColor = UIColor(named: "LIBROGColor")?.cgColor
        nextButton.layer.borderWidth = 1
        nextButton.layer.cornerRadius = 20
        nextButton.tintColor = UIColor(named: "LIBROGColor")
        
        emailWarningLabel.isHidden = true
        pwWarningLabel.isHidden = true
        nicknameWarningLabel.isHidden = true
        isValidTf()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func isValidTf() {
        self.nextButton.isEnabled = (self.isValidEmail && self.isValidPw && self.isValidName) ? true : false
        self.nextButton.layer.borderColor = (self.isValidEmail && self.isValidPw && self.isValidName) ? UIColor(named: "LIBROGColor")?.cgColor : UIColor.lightGray.cgColor
    }
    //MARK: - Actions
    
    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        // 이메일 형식에 알맞게 & 30자 미만
        self.isValidEmail = (text.checkEmail(str: text)) && (text.count < 30)
        emailWarningLabel.isHidden = self.isValidEmail ? true : false
        emailWarningLabel.text = self.isValidEmail ? "" : "이메일 형식이 유효하지 않습니다. (30자 미만)"
        emailUnderlineView.backgroundColor = self.isValidEmail ? UIColor(named: "LIBROGColor") : .red
        isValidTf()
    }
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        // 비밀번호 형식 8자 ~ 20자
        self.isValidPw = (text.count >= 8) && (text.count <= 20)
        pwWarningLabel.isHidden = self.isValidPw ? true : false
        pwWarningLabel.text = self.isValidPw ? "" : "비밀번호는 8~20자리를 입력해주세요."
        pwUnderlineView.backgroundColor = self.isValidPw ? UIColor(named: "LIBROGColor") : .red
        isValidTf()
    }
    
    @IBAction func nicknameTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        // 닉네임 형식 20자 미만
        self.isValidName = text.count < 20
        nicknameWarningLabel.isHidden = self.isValidName ? true : false
        nicknameWarningLabel.text = self.isValidName ? "" : "닉네임은 20자 미만으로 입력해주세요."
        nicknameUnderlineView.backgroundColor = self.isValidName ? UIColor(named: "LIBROGColor") : .red
        isValidTf()
    }
}

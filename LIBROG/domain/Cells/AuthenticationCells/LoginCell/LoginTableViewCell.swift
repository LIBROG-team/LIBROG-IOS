//
//  LoginTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/08/11.
//

import UIKit
import AuthenticationServices

class LoginTableViewCell: UITableViewCell {

    @IBOutlet weak var loginTitleLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailUnderlineView: UIView!
    @IBOutlet weak var passwordUnderlineView: UIView!
    @IBOutlet weak var emailWarningLabel: UILabel!
    @IBOutlet weak var pwWarningLabel: UILabel!
    @IBOutlet weak var goRegisterButton: UIButton!
    @IBOutlet weak var findPasswordButton: UIButton!
    @IBOutlet weak var kakaoLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!

    var isValidEmail: Bool = false
    var isValidPw: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // '더 편한 전자책 리브로그에 오신 것을 환영합니다'
        guard let text = self.loginTitleLabel.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor(named: "LIBROGColor")!, range: (text as NSString).range(of: "리브로그"))
        self.loginTitleLabel.attributedText = attributeString
        // 로그인 버튼 Custom
        loginButton.layer.borderColor = UIColor.lightGray.cgColor
        loginButton.layer.borderWidth = 1
        loginButton.layer.cornerRadius = 20
        loginButton.tintColor = UIColor(named: "LIBROGColor")
        
        emailWarningLabel.isHidden = true
        pwWarningLabel.isHidden = true
        isValidTf()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func isValidTf() {
        self.loginButton.isEnabled = (self.isValidEmail && self.isValidPw) ? true : false
        self.loginButton.layer.borderColor = (self.isValidEmail && self.isValidPw) ? UIColor(named: "LIBROGColor")?.cgColor : UIColor.lightGray.cgColor
    }
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
        passwordUnderlineView.backgroundColor = self.isValidPw ? UIColor(named: "LIBROGColor") : .red
        isValidTf()
    }
}

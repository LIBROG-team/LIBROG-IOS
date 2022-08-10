//
//  LoginViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/22.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTitleLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var emailUnderlineView: UIView!
    @IBOutlet weak var passwordUnderlineView: UIView!
    @IBOutlet weak var emailWarningLabel: UILabel!
    @IBOutlet weak var pwWarningLabel: UILabel!
    
    var email: String!
    var password: String!
    var isValidEmail: Bool = false
    var isValidPw: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    // MARK: 자동 로그인 - userId의 값이 존재할 때
    override func viewDidAppear(_ animated: Bool) {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        if userId > 0 {ScreenManager().goMain(self)}
    }
    func isValidTf() {
        self.loginButton.isEnabled = (self.isValidEmail && self.isValidPw) ? true : false
        self.loginButton.layer.borderColor = (self.isValidEmail && self.isValidPw) ? UIColor(named: "LIBROGColor")?.cgColor : UIColor.lightGray.cgColor
    }
    
    //MARK: Actions
    @IBAction func kakaoLoginButtonDidTap(_ sender: UIButton) {
        KakaoLoginManager().kakaoLogin(self)
    }
    @IBAction func appLoginButtonDidTap(_ sender: UIButton) {
        let appLoginInput = AppLoginInput(email: self.email, password: self.password)
        LoginDataManager().appLoginDataManager(appLoginInput, self)
    }
    @IBAction func goRegisterDidTap(_ sender: UIButton) {
        guard let registerTermVC = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(identifier: "RegisterTermVC") as? RegisterTermViewController else {return}
        registerTermVC.modalPresentationStyle = .fullScreen
        self.present(registerTermVC, animated: true, completion: nil)
    }
    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.email = text
        // 이메일 형식에 알맞게 & 30자 미만
        self.isValidEmail = (text.checkEmail(str: text)) && (text.count < 30)
        emailWarningLabel.isHidden = self.isValidEmail ? true : false
        emailWarningLabel.text = self.isValidEmail ? "" : "이메일 형식이 유효하지 않습니다. (30자 미만)"
        emailUnderlineView.backgroundColor = self.isValidEmail ? UIColor(named: "LIBROGColor") : .red
        isValidTf()
    }
    @IBAction func pwTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.password = text
        // 비밀번호 형식 8자 ~ 20자
        self.isValidPw = (text.count >= 8) && (text.count <= 20)
        pwWarningLabel.isHidden = self.isValidPw ? true : false
        pwWarningLabel.text = self.isValidPw ? "" : "비밀번호는 8~20자리를 입력해주세요."
        passwordUnderlineView.backgroundColor = self.isValidPw ? UIColor(named: "LIBROGColor") : .red
        isValidTf()
    }
    
}
//MARK: - login success API
extension LoginViewController {
    func loginSuccessAPI(_ result: KakaoLoginModel) {
        guard let userId = result.idx else {return}
        UserDefaults.standard.set(userId, forKey: "userId")
        ScreenManager().goMain(self)
    }
    func loginSuccessAPI(_ result: APIModel<AppLoginModel>) {
        guard let isSuccess = result.isSuccess else {return}
        // 앱 로그인 성공 시
        if isSuccess {
            guard let accessToken = result.result?.jwt else {return}
            guard let userId = result.result?.userIdx else {return}
            UserDefaults.standard.set(accessToken, forKey: "accessToken")
            UserDefaults.standard.set(userId, forKey: "userId")
            ScreenManager().goMain(self)
        }
        // 앱 로그인 실패 시 오류 창
        else  {
            guard let errorMessage = result.message else {return}
            let alert = UIAlertController(title: errorMessage, message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
extension String {
    func checkEmail(str: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
    }
}

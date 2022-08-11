//
//  RegisterViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/28.
//

import UIKit

class RegisterViewController: UIViewController {

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
    
    var email: String!
    var password: String!
    var nickname: String!
    var isValidEmail: Bool = false
    var isValidPw: Bool = false
    var isValidName: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    //MARK: 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func isValidTf() {
        self.nextButton.isEnabled = (self.isValidEmail && self.isValidPw && self.isValidName) ? true : false
        self.nextButton.layer.borderColor = (self.isValidEmail && self.isValidPw && self.isValidName) ? UIColor(named: "LIBROGColor")?.cgColor : UIColor.lightGray.cgColor
    }
    //MARK: Actions
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
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.password = text
        // 비밀번호 형식 8자 ~ 20자
        self.isValidPw = (text.count >= 8) && (text.count <= 20)
        pwWarningLabel.isHidden = self.isValidPw ? true : false
        pwWarningLabel.text = self.isValidPw ? "" : "비밀번호는 8~20자리를 입력해주세요."
        pwUnderlineView.backgroundColor = self.isValidPw ? UIColor(named: "LIBROGColor") : .red
        isValidTf()
    }
    @IBAction func nicknameTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.nickname = text
        // 닉네임 형식 20자 미만
        self.isValidName = text.count < 20
        nicknameWarningLabel.isHidden = self.isValidName ? true : false
        nicknameWarningLabel.text = self.isValidName ? "" : "닉네임은 20자 미만으로 입력해주세요."
        nicknameUnderlineView.backgroundColor = self.isValidName ? UIColor(named: "LIBROGColor") : .red
        isValidTf()
    }
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func goNextButtonDidTap(_ sender: UIButton) {
        let email = self.email
        let password = self.password
        let nickname = self.nickname
        
        guard let registerProfileVC = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(identifier: "RegisterProfileVC") as? RegisterProfileViewController else {return}
        
        registerProfileVC.userNameText = nickname
        registerProfileVC.email = email
        registerProfileVC.password = password
        registerProfileVC.nickName = nickname
        
        registerProfileVC.modalPresentationStyle = .fullScreen
        self.present(registerProfileVC, animated: true, completion: nil)
        
//        let registerInput = RegisterInput(email: email, password: password, name: nickname)
//        RegisterDataManager().registerDataManager(registerInput, self)
    }
}

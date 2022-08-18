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
import AuthenticationServices

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTableView: UITableView!
    
    var email: String!
    var password: String!
    var isValidEmail: Bool = false
    var isValidPw: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTableView.delegate = self
        loginTableView.dataSource = self
        
        loginTableView.separatorStyle = .none
        
        let loginNib = UINib(nibName: "LoginTableViewCell", bundle: nil)
        loginTableView.register(loginNib, forCellReuseIdentifier: "LoginTableViewCell")
        
        loginTableView.estimatedRowHeight = 800
        loginTableView.rowHeight = UITableView.automaticDimension
    }
    //MARK: 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // MARK: 자동 로그인 - userId의 값이 존재할 때
    override func viewDidAppear(_ animated: Bool) {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        print("userID::", userId)
        if userId > 0 {ScreenManager().goMain(self)}
    }
    //MARK: Actions
    //MARK: 카카오 로그인
    @objc func kakaoLoginButtonDidTap(_ sender: UIButton) {
        KakaoLoginManager().kakaoLogin(self)
    }
    //MARK: 애플 로그인
    @objc func appleLoginButtonDidTap(_ sender: UIButton) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
    //MARK: 앱 로그인
    @objc func appLoginButtonDidTap(_ sender: UIButton) {
        let appLoginInput = AppLoginInput(email: self.email, password: self.password)
        LoginDataManager().appLoginDataManager(appLoginInput, self)
    }
    //MARK: 비밀번호 찾기
    @objc func findPasswordDidTap(_ sender: UIButton) {
        guard let findPasswordVC = UIStoryboard(name: "FindPassword", bundle: nil).instantiateViewController(identifier: "FindPwVC") as? FindPasswordViewController else {return}
        findPasswordVC.modalPresentationStyle = .fullScreen
        self.present(findPasswordVC, animated: true, completion: nil)
    }
    //MARK: 회원가입
    @objc func goRegisterDidTap(_ sender: UIButton) {
        guard let registerTermVC = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(identifier: "RegisterTermVC") as? RegisterTermViewController else {return}
        registerTermVC.modalPresentationStyle = .fullScreen
        self.present(registerTermVC, animated: true, completion: nil)
    }
    @objc func emailTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.email = text
    }
    @objc func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.password = text
    }
}
// MARK: - 로그인 페이지 tableView delegate
extension LoginViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoginTableViewCell", for: indexPath) as? LoginTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        // MARK: add target
        cell.goRegisterButton.addTarget(self, action: #selector(goRegisterDidTap(_:)), for: .touchUpInside)
        cell.findPasswordButton.addTarget(self, action: #selector(findPasswordDidTap(_:)), for: .touchUpInside)
        cell.kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonDidTap(_:)), for: .touchUpInside)
        cell.appleLoginButton.addTarget(self, action: #selector(appleLoginButtonDidTap(_:)), for: .touchUpInside)
        cell.loginButton.addTarget(self, action: #selector(appLoginButtonDidTap(_:)), for: .touchUpInside)
        cell.emailTextField.addTarget(self, action: #selector(emailTextFieldEditingChanged(_:)), for: .editingChanged)
        cell.passwordTextField.addTarget(self, action: #selector(passwordTextFieldEditingChanged(_:)), for: .editingChanged)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 844
    }
}
//MARK: - 애플 로그인 delegate
extension LoginViewController : ASAuthorizationControllerDelegate  {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let user = credential.user
            print("👨‍🍳 \(user)")
            if let email = credential.email {
                print("✉️ \(email)")
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("error \(error)")
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
            DialogManager().alertErrorDialog(errorMessage, self)
        }
    }
}

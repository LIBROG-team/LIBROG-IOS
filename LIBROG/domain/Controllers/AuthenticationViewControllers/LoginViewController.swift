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
    //MARK: - Actions
//    //MARK: 카카오 로그인
//    @objc func kakaoLoginButtonDidTap(_ sender: UIButton) {
//        KakaoLoginManager().kakaoLogin(self)
//    }
//    //MARK: 애플 로그인
//    @objc func appleLoginButtonDidTap(_ sender: UIButton) {
//        let request = ASAuthorizationAppleIDProvider().createRequest()
//        request.requestedScopes = [.fullName, .email]
//
//        let controller = ASAuthorizationController(authorizationRequests: [request])
//        controller.delegate = self
//        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
//        controller.performRequests()
//    }
    //MARK: 앱 로그인
    @objc func appLoginButtonDidTap(_ sender: UIButton) {
        let appLoginInput = AppLoginInput(email: self.email, password: self.password)
        LoginDataManager().appLoginDataManager(appLoginInput, self)
    }
    //MARK: 비밀번호 찾기
    @objc func findPasswordDidTap(_ sender: UIButton) {
        guard let findPasswordVC = UIStoryboard(name: "Password", bundle: nil).instantiateViewController(identifier: "FindPwVC") as? FindPasswordViewController else {return}
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
//        cell.kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonDidTap(_:)), for: .touchUpInside)
//        cell.appleLoginButton.addTarget(self, action: #selector(appleLoginButtonDidTap(_:)), for: .touchUpInside)
        cell.loginButton.addTarget(self, action: #selector(appLoginButtonDidTap(_:)), for: .touchUpInside)
        cell.emailTextField.addTarget(self, action: #selector(emailTextFieldEditingChanged(_:)), for: .editingChanged)
        cell.passwordTextField.addTarget(self, action: #selector(passwordTextFieldEditingChanged(_:)), for: .editingChanged)
        
        return cell
    }
}
////MARK: - 애플 로그인 delegate
//extension LoginViewController : ASAuthorizationControllerDelegate  {
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        switch authorization.credential {
//            case let appleIDCredential as ASAuthorizationAppleIDCredential:
//                // Create an account in your system.
//                let userIdentifier = appleIDCredential.user
//                let fullName = appleIDCredential.fullName
//                let email = appleIDCredential.email
//                
//                if  let authorizationCode = appleIDCredential.authorizationCode,
//                    let identityToken = appleIDCredential.identityToken,
//                    // authString: authorizationCode를 String으로 변환
//                    let authString = String(data: authorizationCode, encoding: .utf8),
//                    let tokenString = String(data: identityToken, encoding: .utf8) {
//                    print("authorizationCode: \(authorizationCode)")
//                    print("identityToken: \(identityToken)")
//                    print("authString: \(authString)")
//                    print("tokenString: \(tokenString)")
//                    
//                    //MARK: 리브로그 애플 로그인 api 호출
//                    let appleLoginInput = AppleLoginInput(code: authString)
//                    LoginDataManager().appleLoginDataManager(appleLoginInput, self)
//                }
//                
//                print("useridentifier: \(userIdentifier)")
//                print("fullName: \(fullName)")
//                print("✉️ email: \(email)")
//                
//            case let passwordCredential as ASPasswordCredential:
//                // Sign in using an existing iCloud Keychain credential.
//                let username = passwordCredential.user
//                let password = passwordCredential.password
//                
//                print("👨‍🍳 username: \(username)")
//                print("password: \(password)")
//                
//            default:
//                break
//        }
//    }
//    
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        print("error \(error)")
//    }
//}
//MARK: - login success API
extension LoginViewController {
//    // MARK: kakao login
//    func loginSuccessAPI(_ result: KakaoLoginModel) {
//        guard let userId = result.idx else {return}
//        UserDefaults.standard.set(userId, forKey: "userId")
//        ScreenManager().goMain(self)
//    }
//    // MARK: Apple login
//    func loginSuccessAPI(_ result: AppleLoginModel) {
//        guard let userId = result.idx else {return}
//        UserDefaults.standard.set(userId, forKey: "userId")
//        ScreenManager().goMain(self)
//    }
    // MARK: app login
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

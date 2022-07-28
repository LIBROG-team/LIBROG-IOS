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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // '더 편한 전자책 리브로그에 오신 것을 환영합니다'
        guard let text = self.loginTitleLabel.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor(named: "LIBROGColor")!, range: (text as NSString).range(of: "리브로그"))
        self.loginTitleLabel.attributedText = attributeString
        // 로그인 버튼 Custom
        loginButton.layer.borderColor = UIColor(named: "LIBROGColor")?.cgColor
        loginButton.layer.borderWidth = 1
        loginButton.layer.cornerRadius = 20
        loginButton.tintColor = UIColor(named: "LIBROGColor")
    }
    
    @IBAction func kakaoLoginButtonDidTap(_ sender: UIButton) {
        KakaoLoginManager().kakaoLogin(self)
    }
    @IBAction func kakaoLogoutButtonDidTap(_ sender: UIButton) {
        KakaoLoginManager().kakaoLogout()
    }
    @IBAction func goRegisterDidTap(_ sender: UIButton) {
        guard let registerTermVC = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(identifier: "RegisterTermVC") as? RegisterTermViewController else {return}
        registerTermVC.modalPresentationStyle = .fullScreen
        self.present(registerTermVC, animated: true, completion: nil)
    }
}
extension LoginViewController {
    func loginSuccessAPI(_ result: KakaoLoginResultModel) {
        guard let userId = result.idx else {return}
        UserDefaults.standard.set(userId, forKey: "userId")
        self.goMain()
    }
    func goMain() {
        // 첫화면으로 전환
        guard let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBarController") as? UITabBarController else {return}
        tabBarController.modalPresentationStyle = .fullScreen
        self.view.window?.windowScene?.keyWindow?.rootViewController = tabBarController
    }
}

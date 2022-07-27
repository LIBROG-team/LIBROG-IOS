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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let text = self.loginTitleLabel.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor(named: "LIBROGColor"), range: (text as NSString).range(of: "리브로그"))
        self.loginTitleLabel.attributedText = attributeString
    }
    
    @IBAction func kakaoLoginButtonDidTap(_ sender: UIButton) {
        KakaoLoginManager().kakaoLogin(self)
    }
    @IBAction func kakaoLogoutButtonDidTap(_ sender: UIButton) {
        KakaoLoginManager().kakaoLogout()
    }
}

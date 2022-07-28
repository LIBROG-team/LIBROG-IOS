//
//  RegisterProfileViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/28.
//

import UIKit

class RegisterProfileViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 리브로그 시작하기 버튼 Custom
        registerButton.layer.borderColor = UIColor(named: "LIBROGColor")?.cgColor
        registerButton.layer.borderWidth = 1
        registerButton.layer.cornerRadius = 20
        registerButton.tintColor = UIColor(named: "LIBROGColor")
    }
    
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func registerButtonDidTap(_ sender: UIButton) {
    }
}

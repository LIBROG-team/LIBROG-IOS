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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 다음 버튼 Custom
        nextButton.layer.borderColor = UIColor(named: "LIBROGColor")?.cgColor
        nextButton.layer.borderWidth = 1
        nextButton.layer.cornerRadius = 20
        nextButton.tintColor = UIColor(named: "LIBROGColor")
    }
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func goNextButtonDidTap(_ sender: UIButton) {
        guard let registerProfileVC = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(identifier: "RegisterProfileVC") as? RegisterProfileViewController else {return}
        registerProfileVC.modalPresentationStyle = .fullScreen
        self.present(registerProfileVC, animated: true, completion: nil)
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let nickname = nicknameTextField.text!
        
        let registerInput = RegisterInput(email: email, password: password, name: nickname)
        RegisterDataManager().registerDataManager(registerInput, self)
    }
    
}

extension RegisterViewController {
    func RegisterSuccessAPI(_ result: RegisterModel) {
        
    }
}

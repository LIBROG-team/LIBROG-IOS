//
//  RegisterTermViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/28.
//

import UIKit

class RegisterTermViewController: UIViewController {
    @IBOutlet weak var goNextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 다음 버튼 Custom
        goNextButton.layer.borderColor = UIColor(named: "LIBROGColor")?.cgColor
        goNextButton.layer.borderWidth = 1
        goNextButton.layer.cornerRadius = 20
        goNextButton.tintColor = UIColor(named: "LIBROGColor")
    }
    @IBAction func goNextButtonDidTap(_ sender: UIButton) {
        guard let registerVC = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(identifier: "RegisterVC") as? RegisterViewController else {return}
        registerVC.modalPresentationStyle = .fullScreen
        self.present(registerVC, animated: true, completion: nil)
    }
    
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

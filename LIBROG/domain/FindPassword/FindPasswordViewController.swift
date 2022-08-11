//
//  FindPasswordViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/08/11.
//

import UIKit

class FindPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendEmailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 이메일 전송 버튼 Custom
        sendEmailButton.layer.borderColor = UIColor(named: "LIBROGColor")?.cgColor
        sendEmailButton.layer.borderWidth = 1
        sendEmailButton.layer.cornerRadius = 20
        sendEmailButton.tintColor = UIColor(named: "LIBROGColor")
    }

    @IBAction func sendEmailButtonDidTap(_ sender: UIButton) {
        guard let email = emailTextField.text else {return}
        let findPasswordInput = FindPasswordInput(email: email)
        FindPasswordDataManager().findPasswordDataManager(findPasswordInput, self)
    }
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - 비밀번호 찾기 api success
extension FindPasswordViewController {
    func findPasswordSuccessAPI(_ result: APIModel<ResultModel>) {
        guard let isSuccess = result.isSuccess else {return}
        if isSuccess {
            self.dismiss(animated: true, completion: nil)
        } else {
            guard let errorMessage = result.message else {return}
            ScreenManager().alertErrorDialog(errorMessage, self)
        }
    }
}

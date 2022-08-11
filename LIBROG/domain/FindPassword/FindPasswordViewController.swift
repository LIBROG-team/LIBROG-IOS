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
    //MARK: 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
            ScreenManager().emailSendSuccessDialog("이메일 전송이 되었습니다.", "로그인 화면으로 이동합니다.", self)
//            guard let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(identifier: "LoginVC") as? LoginViewController else {return}
//            loginVC.modalPresentationStyle = .fullScreen
//            self.present(loginVC, animated: true, completion: nil)
        } else {
            guard let errorMessage = result.message else {return}
            ScreenManager().alertErrorDialog(errorMessage, self)
        }
    }
}

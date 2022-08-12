//
//  RegisterViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/28.
//

import UIKit

class RegisterViewController: UIViewController {
    var email: String!
    var password: String!
    var nickname: String!
    
    @IBOutlet weak var registerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableView.delegate = self
        registerTableView.dataSource = self
        
        registerTableView.separatorStyle = .none
        
        let registerNib = UINib(nibName: "RegisterTableViewCell", bundle: nil)
        registerTableView.register(registerNib, forCellReuseIdentifier: "RegisterTableViewCell")
        
        registerTableView.estimatedRowHeight = 500
        registerTableView.rowHeight = UITableView.automaticDimension
    }
    //MARK: 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //MARK: - Actions
    @objc func emailTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.email = text
    }
    @objc func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.password = text
    }
    @objc func nicknameTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.nickname = text
    }
    //MARK: 다음 버튼
    @objc func goNextButtonDidTap(_ sender: UIButton) {
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
    }
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - 회원가입 이메일/비밀번호/닉네임 입력 페이지 tableView delegate
extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterTableViewCell", for: indexPath) as? RegisterTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        // MARK: add target
        cell.emailTextField.addTarget(self, action: #selector(emailTextFieldEditingChanged(_:)), for: .editingChanged)
        cell.passwordTextField.addTarget(self, action: #selector(passwordTextFieldEditingChanged(_:)), for: .editingChanged)
        cell.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldEditingChanged(_:)), for: .editingChanged)
        cell.nextButton.addTarget(self, action: #selector(goNextButtonDidTap(_:)), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 844
    }
}

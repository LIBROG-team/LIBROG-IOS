//
//  FindPasswordViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/08/11.
//

import UIKit

class FindPasswordViewController: UIViewController {
    @IBOutlet weak var findPasswordTableView: UITableView!
    
    var email: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        findPasswordTableView.delegate = self
        findPasswordTableView.dataSource = self
        
        findPasswordTableView.separatorStyle = .none
        
        let findPwNib = UINib(nibName: "FindPasswordTableViewCell", bundle: nil)
        findPasswordTableView.register(findPwNib, forCellReuseIdentifier: "FindPasswordTableViewCell")
        
        findPasswordTableView.estimatedRowHeight = 800
        findPasswordTableView.rowHeight = UITableView.automaticDimension
    }
    //MARK: 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //MARK: Actions
    @objc func emailTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.email = text
    }
    @objc func sendEmailButtonDidTap(_ sender: UIButton) {
        guard let email = self.email else {return}
        let findPasswordInput = FindPasswordInput(email: email)
        FindPasswordDataManager().findPasswordDataManager(findPasswordInput, self)
    }
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - 비밀번호 찾기 페이지 tableView delegate
extension FindPasswordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FindPasswordTableViewCell", for: indexPath) as? FindPasswordTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        // MARK: add target
        cell.emailTextField.addTarget(self, action: #selector(emailTextFieldEditingChanged(_:)), for: .editingChanged)
        cell.sendEmailButton.addTarget(self, action: #selector(sendEmailButtonDidTap(_:)), for: .touchUpInside)
        
        return cell
    }
}
// MARK: - 비밀번호 찾기 api success
extension FindPasswordViewController {
    func findPasswordSuccessAPI(_ result: APIModel<ResultModel>) {
        guard let isSuccess = result.isSuccess else {return}
        if isSuccess {
            DialogManager().emailSendSuccessDialog("이메일 전송이 되었습니다.", "로그인 화면으로 이동합니다.", self)
        } else {
            guard let errorMessage = result.message else {return}
            DialogManager().alertErrorDialog(errorMessage, self)
        }
    }
}

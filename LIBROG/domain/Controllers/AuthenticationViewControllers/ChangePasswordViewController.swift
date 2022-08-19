//
//  ChangePasswordViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/08/19.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var changePasswordTableView: UITableView!
    
    var oldPW: String!
    var newPW: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changePasswordTableView.delegate = self
        changePasswordTableView.dataSource = self
        
        changePasswordTableView.separatorStyle = .none
        
        let changePwNib = UINib(nibName: "ChangePasswordTableViewCell", bundle: nil)
        changePasswordTableView.register(changePwNib, forCellReuseIdentifier: "ChangePasswordTableViewCell")
        
        changePasswordTableView.estimatedRowHeight = 800
        changePasswordTableView.rowHeight = UITableView.automaticDimension
    }
    //MARK: Actions
    @objc func oldPasswordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.oldPW = text
    }
    @objc func newPasswordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.newPW = text
    }
    // 비밀번호 변경 버튼 클릭
    @objc func completeButtonDidTap(_ sender: UIButton) {
        // 비밀번호 변경 api 호출
        guard let oldPW = self.oldPW else {return}
        guard let newPW = self.newPW else {return}
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let changePasswordInput = ChangePasswordInput(userIdx: userId, oldPassword: oldPW, newPassword: newPW)
        ChangePasswordDataManager().changePasswordDataManager(changePasswordInput, self)
    }
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - 비밀번호 변경 페이지 tableView delegate
extension ChangePasswordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChangePasswordTableViewCell", for: indexPath) as? ChangePasswordTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        // MARK: add target
        cell.oldPasswordTextField.addTarget(self, action: #selector(oldPasswordTextFieldEditingChanged(_:)), for: .editingChanged)
        cell.newPasswordTextField.addTarget(self, action: #selector(newPasswordTextFieldEditingChanged(_:)), for: .editingChanged)
        cell.completeButton.addTarget(self, action: #selector(completeButtonDidTap(_:)), for: .touchUpInside)
        
        return cell
    }
}
extension ChangePasswordViewController {
    func changePasswordSuccessAPI(_ result: APIModel<ChangePasswordModel>) {
        // 프로필 페이지로 이동
        self.alerDialog()
    }
    func alerDialog() {
        let alert = UIAlertController(title: "비밀번호 변경이 완료되었습니다.", message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel) { action in
            // 독서기록 삭제 api 호출
            ScreenManager().goMainPages(4, self)
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}

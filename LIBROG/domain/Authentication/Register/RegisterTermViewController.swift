//
//  RegisterTermViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/28.
//

import UIKit
import DLRadioButton

class RegisterTermViewController: UIViewController {
    @IBOutlet weak var registerTermTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTermTableView.delegate = self
        registerTermTableView.dataSource = self
        
        registerTermTableView.separatorStyle = .none
        
        let termNib = UINib(nibName: "RegisterTermTableViewCell", bundle: nil)
        registerTermTableView.register(termNib, forCellReuseIdentifier: "RegisterTermTableViewCell")
        
        registerTermTableView.estimatedRowHeight = 500
        registerTermTableView.rowHeight = UITableView.automaticDimension
    }
    //MARK: Actions
    @objc func goNextButtonDidTap(_ sender: UIButton) {
        registerTermTableView.reloadData()
    }
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - 회원가입 약관 동의 페이지 tableView delegate
extension RegisterTermViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterTermTableViewCell", for: indexPath) as? RegisterTermTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        // MARK: add target
        cell.goNextButton.addTarget(self, action: #selector(goNextButtonDidTap(_:)), for: .touchUpInside)
        if cell.isEnable {
            goNextPage()
        }
        return cell
    }
}
extension RegisterTermViewController {
    func goNextPage() {
        guard let registerVC = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(identifier: "RegisterVC") as? RegisterViewController else {return}
        registerVC.modalPresentationStyle = .fullScreen
        self.present(registerVC, animated: true, completion: nil)
    }
}

//
//  SettingViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/08/11.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var settingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingTableView.delegate = self
        settingTableView.dataSource = self
    }
    @IBAction func goBackButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - 프로필 페이지 tableView delegate
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row == 0 {cell.textLabel?.text = "탈퇴하기"}
        else if indexPath.row == 1 {cell.textLabel?.text = "문의하기"}
        else if indexPath.row == 2 {cell.textLabel?.text = "개인정보취급방침"}
        else if indexPath.row == 3 {cell.textLabel?.text = "홈페이지 방문"}
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    //클릭 이벤트 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // MARK: 더보기 버튼 클릭
        if indexPath.row == 0 {
            DialogManager().alertQuitDialog("탈퇴하시겠습니까?", self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
//MARK: - 유저 탈퇴 api
extension SettingViewController {
    func userDeleteSuccessAPI(_ result: APIModel<APIModel<DeleteUserModel>>) {
        DialogManager().emailSendSuccessDialog("탈퇴되었습니다.", "로그인창으로 이동합니다.", self)
    }
}

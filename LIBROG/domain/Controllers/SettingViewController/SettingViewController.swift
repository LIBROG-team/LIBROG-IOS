//
//  SettingViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/08/11.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    @IBOutlet weak var settingTableView: UITableView!
    
    let settingMenuArray = ["프로필 설정", "홈페이지 방문", "개인정보취급방침", "문의하기", "비밀번호 변경", "프로모션 코드 입력", "탈퇴하기"]
    
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
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let tag = indexPath.row
        for i in 0...6 {
            if (i == tag) {cell.textLabel?.text = settingMenuArray[i]}
        }
        cell.textLabel?.snp.makeConstraints { make in
            make.center.equalTo(cell)
            make.left.equalToSuperview().offset(34)
        }
        let image : UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "arrow_left")
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        cell.addSubview(image)
        image.snp.makeConstraints{ make in
            make.centerY.equalTo(cell)
            make.right.equalTo(cell).offset(-39)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    //클릭 이벤트 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // MARK: 탈퇴하기 클릭
        if indexPath.row == 6 {
            DialogManager().alertQuitDialog("탈퇴하시겠습니까?", self)
        }
        // MARK: 비밀번호 변경 클릭
        else if indexPath.row == 4 {
            guard let changePwVC = UIStoryboard(name: "Password", bundle: nil).instantiateViewController(identifier: "ChangePwVC") as? ChangePasswordViewController else {return}
            
            changePwVC.modalPresentationStyle = .fullScreen
            self.present(changePwVC, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
//MARK: - 유저 탈퇴 api
extension SettingViewController {
    func userDeleteSuccessAPI() {
        // 앱 내 user data 삭제
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
        UserDefaults.standard.removeObject(forKey: "userId")
        
        DialogManager().emailSendSuccessDialog("탈퇴되었습니다.", "로그인창으로 이동합니다.", self)
    }
}

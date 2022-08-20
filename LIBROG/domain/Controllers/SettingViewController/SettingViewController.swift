//
//  SettingViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/08/11.
//

import UIKit
import SnapKit
import SafariServices

class SettingViewController: UIViewController {
    @IBOutlet weak var settingTableView: UITableView!
    
    let settingMenuArray = ["프로필 설정", "홈페이지 방문", "개인정보취급방침", "문의하기", "비밀번호 변경", "쿠폰 입력하기", "탈퇴하기"]
    var loginType: String!
    var introData: IntroModel!
    
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
        // MARK: 프로필 설정
        if indexPath.row == 0 {
            if let loginType = self.introData.type {
                DialogManager().alertErrorDialog("\(loginType)로 로그인한 계정은\n프로필 설정을 할 수 없습니다.", self)
            } else {
                guard let ModifyProfileVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(identifier: "ModifyProfileVC") as? ModifyProfileViewController else {return}
                ModifyProfileVC.profileImgUrl = self.introData.profileImgUrl
                ModifyProfileVC.nickName = self.introData.name
                ModifyProfileVC.introduction = self.introData.introduction
                
                ModifyProfileVC.modalPresentationStyle = .fullScreen
                self.present(ModifyProfileVC, animated: true, completion: nil)
            }
        }
        // MARK: 홈페이지 방문
        else if indexPath.row == 1 {
            self.linkTo("https://blog.naver.com/librog")
        }
        // MARK: 개인정보취급방침
        else if indexPath.row == 2 {
            self.linkTo("https://librog.shop/blog/privacypolicy.html")
        }
        // MARK: 문의하기
        else if indexPath.row == 3 {
            let alert = UIAlertController(title: "librogmaster@gmail.com", message: "위 주소로 문의해주시길 바랍니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        // MARK: 비밀번호 변경
        else if indexPath.row == 4 {
            if let loginType = self.introData.type {
                DialogManager().alertErrorDialog("\(loginType)로 로그인한 계정은\n비밀번호 변경을 할 수 없습니다.", self)
            } else {
                guard let changePwVC = UIStoryboard(name: "Password", bundle: nil).instantiateViewController(identifier: "ChangePwVC") as? ChangePasswordViewController else {return}
                
                changePwVC.modalPresentationStyle = .fullScreen
                self.present(changePwVC, animated: true, completion: nil)
            }
        }
        // MARK: 쿠폰입력하기
        else if indexPath.row == 5 {
            self.linkTo("https://librog.shop/blog/promotion.html")
        }
        // MARK: 탈퇴하기
        else if indexPath.row == 6 {
            DialogManager().alertQuitDialog("탈퇴하시겠습니까?", self)
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
extension SettingViewController {
    //MARK: link func
    func linkTo(_ urlStr: String) {
        let url = NSURL(string: urlStr)
        let linkView: SFSafariViewController = SFSafariViewController(url: url as! URL)
        self.present(linkView, animated: true, completion: nil)
    }
}

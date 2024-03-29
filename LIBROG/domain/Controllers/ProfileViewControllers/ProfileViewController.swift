//
//  ProfileViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/18.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var aboutMeLabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    
    var flowerPotCount = 0
    var readingBookCount = 0
    var starRatingCount = 0
    var quoteCount = 0
    var bookReportCount = 0
    
    var introData: IntroModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.separatorStyle = .none
        
        let introNib = UINib(nibName: "ProfileIntroTableViewCell", bundle: nil)
        profileTableView.register(introNib, forCellReuseIdentifier: "ProfileIntroTableViewCell")
        let statisticNib = UINib(nibName: "ProfileStatisticTableViewCell", bundle: nil)
        profileTableView.register(statisticNib, forCellReuseIdentifier: "ProfileStatisticTableViewCell")
        let flowerpotNib = UINib(nibName: "ProfileFlowerpotTableViewCell", bundle: nil)
        profileTableView.register(flowerpotNib, forCellReuseIdentifier: "ProfileFlowerpotTableViewCell")
        let logoutNib = UINib(nibName: "LogoutTableViewCell", bundle: nil)
        profileTableView.register(logoutNib, forCellReuseIdentifier: "LogoutTableViewCell")
        let loginTypeNib = UINib(nibName: "ProfileLoginTypeTableViewCell", bundle: nil)
        profileTableView.register(loginTypeNib, forCellReuseIdentifier: "ProfileLoginTypeTableViewCell")
        
        //MARK: call api
        ProfileDataManager().statisticDataManager(self)
        ProfileDataManager().introDataManager(self)
    }
    override func viewDidAppear(_ animated: Bool) {
        ProfileDataManager().introDataManager(self)
        ProfileDataManager().statisticDataManager(self)
    }
    //MARK: Actions
    // 환경설정 페이지로 이동
    @IBAction func settingButtonDidTap(_ sender: UIButton) {
        guard let settingVC = UIStoryboard(name: "Setting", bundle: nil).instantiateViewController(identifier: "SettingVC") as? SettingViewController else {return}
        guard let VCintroData = self.introData else {return}
        settingVC.introData = VCintroData
        settingVC.modalPresentationStyle = .fullScreen
        self.present(settingVC, animated: true, completion: nil)
    }
    // 식물도감 페이지로 이동
    @objc func goFlowerpotPage() {
        guard let AddFlowerPotVC = UIStoryboard(name: "AddFlowerPot", bundle: nil).instantiateViewController(identifier: "AddFlowerPotVC") as? AddFlowerPotViewController else {return}
        AddFlowerPotVC.isAddFlowerpot = false
        AddFlowerPotVC.modalPresentationStyle = .fullScreen
        self.present(AddFlowerPotVC, animated: true, completion: nil)
    }
    // 로그아웃
    @objc func logout() {
        // 앱 내 user data 삭제
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
        UserDefaults.standard.removeObject(forKey: "userId")
        // 로그인 페이지로 전환
        guard let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(identifier: "LoginVC") as? LoginViewController else {return}
        loginVC.modalPresentationStyle = .fullScreen
        self.view.window?.windowScene?.keyWindow?.rootViewController = loginVC
    }
}

// MARK: - 프로필 페이지 tableView delegate
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // intro
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileIntroTableViewCell", for: indexPath) as? ProfileIntroTableViewCell else {
                return UITableViewCell()
            }
            if let profileData = self.introData {
                cell.setUpIntro(profileData)
            }
            cell.selectionStyle = .none
            return cell
        }
        // 식물도감
        else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileFlowerpotTableViewCell", for: indexPath) as? ProfileFlowerpotTableViewCell else {
                return UITableViewCell()
            }
            cell.flowerpotButton.addTarget(self, action: #selector(goFlowerpotPage), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
//        // social login type
//        else if indexPath.row == 2 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileLoginTypeTableViewCell", for: indexPath) as? ProfileLoginTypeTableViewCell else {
//                return UITableViewCell()
//            }
//            if let loginType = self.introData {
//                cell.setLoginType(loginType)
//            }
//            cell.selectionStyle = .none
//            return cell
//        }
        // logout
        else if indexPath.row == 7 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LogoutTableViewCell", for: indexPath) as? LogoutTableViewCell else {
                return UITableViewCell()
            }
            cell.logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
        // user statistic
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileStatisticTableViewCell", for: indexPath) as? ProfileStatisticTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            if indexPath.row == 2 {cell.setProfileMenu("Leaf", "화분", self.flowerPotCount, "개")}
            else if indexPath.row == 3 { cell.setProfileMenu("BookBookmark", "읽은 책", self.readingBookCount, "권") }
            else if indexPath.row == 4 { cell.setProfileMenu("Star", "별점", self.starRatingCount, "개") }
            else if indexPath.row == 5 { cell.setProfileMenu("PencilSimpleLine", "한 줄 기록", self.quoteCount, "개") }
            else if indexPath.row == 6 { cell.setProfileMenu("NotePencil", "독서록", self.bookReportCount, "개") }
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {return 128}
        else if indexPath.row == 1 {return 120}
//        else if indexPath.row == 2 {return 152}
        else if indexPath.row == 8 {return 80}
        else {return 72}
    }
    
    // 클릭 이벤트 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 프로필 수정 페이지로 이동
        if indexPath.row == 0 {
            guard let ModifyProfileVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(identifier: "ModifyProfileVC") as? ModifyProfileViewController else {return}
            ModifyProfileVC.profileImgUrl = self.introData.profileImgUrl
            ModifyProfileVC.nickName = self.introData.name
            ModifyProfileVC.introduction = self.introData.introduction
            
            ModifyProfileVC.modalPresentationStyle = .fullScreen
            self.present(ModifyProfileVC, animated: true, completion: nil)
            let loginType = self.introData.type
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
// MARK: - api success
extension ProfileViewController {
    func introSuccessAPI(_ result: IntroModel) {
        self.introData = result
        profileTableView.reloadData()
    }
    func statisticSuccessAPI(_ result: StatisticModel) {
        self.flowerPotCount = result.flowerCnt!
        self.readingBookCount = result.readingCnt!
        self.starRatingCount = result.starRatingCnt!
        self.quoteCount = result.quoteCnt!
        self.bookReportCount = result.contentCnt!
        profileTableView.reloadData()
    }
}

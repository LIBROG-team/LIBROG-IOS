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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        profileTableView.separatorStyle = .none
        
        let menuNib = UINib(nibName: "ProfileTableViewCell", bundle: nil)
        profileTableView.register(menuNib, forCellReuseIdentifier: "ProfileTableViewCell")
        
        StatisticDataManager().statisticDataManager(self)
    }
    
    @IBAction func settingButtonDidTap(_ sender: UIButton) {
        let settingVC = UIStoryboard(name: "Setting", bundle: nil).instantiateViewController(identifier: "SettingVC")
        settingVC.modalPresentationStyle = .fullScreen
        self.present(settingVC, animated: true, completion: nil)
    }
}

// MARK: - 프로필 페이지 tableView delegate
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        if indexPath.row == 0 { cell.setProfileMenu("Leaf", "화분", self.flowerPotCount, "개") }
        else if indexPath.row == 1 { cell.setProfileMenu("BookBookmark", "읽은 책", self.readingBookCount, "권") }
        else if indexPath.row == 2 { cell.setProfileMenu("Star", "별점", self.starRatingCount, "개") }
        else if indexPath.row == 3 { cell.setProfileMenu("PencilSimpleLine", "한 줄 기록", self.quoteCount, "개") }
        else if indexPath.row == 4 { cell.setProfileMenu("NotePencil", "독서록", self.bookReportCount, "개") }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

extension ProfileViewController {
    func statisticSuccessAPI(_ result: StatisticResultModel) {
        self.flowerPotCount = result.flowerCnt!
        self.readingBookCount = result.readingCnt!
        self.starRatingCount = result.starRatingCnt!
        self.quoteCount = result.quoteCnt!
        self.bookReportCount = result.contentCnt!
        profileTableView.reloadData()
    }
}

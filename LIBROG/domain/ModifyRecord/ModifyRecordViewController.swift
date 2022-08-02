//
//  ModifyRecordViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/26.
//

import UIKit

class ModifyRecordViewController: UIViewController {
    @IBOutlet weak var modifyRecordTableView: UITableView!
    
    var recordData: RecordDetailResultModel!
    var isCompleteButtonTap = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        modifyRecordTableView.delegate = self
        modifyRecordTableView.dataSource = self
        
        modifyRecordTableView.separatorStyle = .none
        
        let modifylNib = UINib(nibName: "ModifyRecordTableViewCell", bundle: nil)
        modifyRecordTableView.register(modifylNib, forCellReuseIdentifier: "ModifyRecordTableViewCell")
    }
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func modifyButtonDidTap(_ sender: UIButton) {
        isCompleteButtonTap = true
        modifyRecordTableView.reloadData()
    }
}
extension ModifyRecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyRecordTableViewCell", for: indexPath) as? ModifyRecordTableViewCell else {
            return UITableViewCell()
        }
        if isCompleteButtonTap == false {
            cell.setRecordData(self.recordData)
        }
        if isCompleteButtonTap == true {
            cell.postRecord(self.recordData)
            goMain()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 667
    }
}
extension ModifyRecordViewController {
    func goMain() {
        // 첫화면으로 전환
        guard let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBarController") as? UITabBarController else {return}
        tabBarController.modalPresentationStyle = .fullScreen
        self.view.window?.windowScene?.keyWindow?.rootViewController = tabBarController
    }
}

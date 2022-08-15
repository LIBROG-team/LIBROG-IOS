//
//  RecordDetailViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/26.
//

import UIKit

class RecordDetailViewController: UIViewController {
    @IBOutlet weak var recordDetailNB: UINavigationBar!
    @IBOutlet weak var recordDetailTableView: UITableView!
    
    var recordIdx: Int!
    var recordData: RecordDetailModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recordDetailTableView.delegate = self
        recordDetailTableView.dataSource = self
        
        recordDetailTableView.separatorStyle = .none
        
        let recordDetailNib = UINib(nibName: "RecordDetailTableViewCell", bundle: nil)
        recordDetailTableView.register(recordDetailNib, forCellReuseIdentifier: "RecordDetailTableViewCell")
        
        RecordDetailDataManager().recordDetailDataManager(self.recordIdx, self)
    }
    override func viewDidAppear(_ animated: Bool) {
        RecordDetailDataManager().recordDetailDataManager(self.recordIdx, self)
    }
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    // 수정하러 가는 버튼
    @IBAction func goModifyButtonDidTap(_ sender: UIBarButtonItem) {
        guard let modifyVC = UIStoryboard(name: "RecordDetail", bundle: nil).instantiateViewController(identifier: "ModifyRecordVC") as? ModifyRecordViewController else {return}
        modifyVC.recordData = self.recordData
        modifyVC.modalPresentationStyle = .fullScreen
        self.present(modifyVC, animated: true, completion: nil)
    }
}
extension RecordDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordDetailTableViewCell", for: indexPath) as? RecordDetailTableViewCell else {
            return UITableViewCell()
        }
        if let data = self.recordData {
            cell.setRecordData(data)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 667
    }
}
// MARK: - 독서 상세 기록 조회 api
extension RecordDetailViewController {
    func recordDetailSuccessAPI(_ result: RecordDetailModel) {
        self.recordData = result
        recordDetailTableView.reloadData()
        self.recordDetailNB.topItem?.title = result.name!
    }
}

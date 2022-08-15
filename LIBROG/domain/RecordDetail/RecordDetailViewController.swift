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
    // MARK: - Actions
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    // 수정하러 가는 버튼
    @IBAction func goModifyButtonDidTap(_ sender: UIBarButtonItem) {
        showActionSheet()
    }
    // MARK: - Functions
    func showActionSheet() {
        let actionSheet = UIAlertController(title: "독서기록 메뉴", message: "메뉴를 선택해주세요", preferredStyle: .actionSheet)
        let modifyRecord = UIAlertAction(title: "수정", style: .default) { action in
            // 독서기록 수정 페이지로 이동
            guard let modifyVC = UIStoryboard(name: "RecordDetail", bundle: nil).instantiateViewController(identifier: "ModifyRecordVC") as? ModifyRecordViewController else {return}
            modifyVC.recordData = self.recordData
            modifyVC.modalPresentationStyle = .fullScreen
            self.present(modifyVC, animated: true, completion: nil)
        }
        let deleteRecord = UIAlertAction(title: "삭제", style: .destructive) { action in
            // 독서기록 삭제 api 호출
            let deleteRecordInput = DeleteRecordInput(recordsIdx: self.recordIdx)
            RecordDetailDataManager().deleteRecordDataManager(deleteRecordInput, self)
        }
        let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheet.addAction(modifyRecord)
        actionSheet.addAction(deleteRecord)
        actionSheet.addAction(actionCancel)
        self.present(actionSheet, animated: true, completion: nil)
    }
}
// MARK: - 독서기록 상세 내용 tableView delegate
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
// MARK: - 독서기록 api
extension RecordDetailViewController {
    // MARK: 독서기록 상세 조회 api
    func recordDetailSuccessAPI(_ result: RecordDetailModel) {
        self.recordData = result
        recordDetailTableView.reloadData()
        self.recordDetailNB.topItem?.title = result.name!
    }
    // MARK: 독서기록 삭제 api
    func deleteRecordSuccessAPI() {
        self.dismiss(animated: true, completion: nil)
    }
}

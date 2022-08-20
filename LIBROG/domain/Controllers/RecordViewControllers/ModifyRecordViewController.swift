//
//  ModifyRecordViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/26.
//

import UIKit

class ModifyRecordViewController: UIViewController {
    @IBOutlet weak var modifyRecordTableView: UITableView!
    
    var recordData: RecordDetailModel!
    var isCompleteButtonTap = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        modifyRecordTableView.delegate = self
        modifyRecordTableView.dataSource = self
        
        modifyRecordTableView.separatorStyle = .none
        
        let modifylNib = UINib(nibName: "ModifyRecordTableViewCell", bundle: nil)
        modifyRecordTableView.register(modifylNib, forCellReuseIdentifier: "ModifyRecordTableViewCell")
    }
    //MARK: 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //MARK: - Actions
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    // 독서기록 삭제 버튼
    @IBAction func deleteRecordButtonDidTap(_ sender: UIBarButtonItem) {
        self.alerDialog()
    }
    // 독서기록 수정 버튼
    @IBAction func modifyButtonDidTap(_ sender: UIButton) {
        isCompleteButtonTap = true
        modifyRecordTableView.reloadData()
    }
    func alerDialog() {
        let alert = UIAlertController(title: "독서기록을 삭제하시겠습니까?", message: "", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "네", style: .destructive) { action in
            // 독서기록 삭제 api 호출
            let recordIdx = self.recordData.readingRecordIdx
            let deleteRecordInput = DeleteRecordInput(recordsIdx: recordIdx)
            ModifyRecordDataManager().deleteRecordDataManager(deleteRecordInput, self)
        }
        let cancel = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        self.present(alert, animated: true, completion: nil)
    }
}
// MARK: - 독서기록 수정 페이지 tableView delegate
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
            cell.postRecord(self.recordData, self)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 667
    }
}
// MARK: - 독서기록 삭제 api
extension ModifyRecordViewController {
    func deleteRecordSuccessAPI() {
        let alert = UIAlertController(title: "독서기록을 삭제하였습니다.", message: "독서기록 페이지로 이동합니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel) {action in
            ScreenManager().goMainPages(1, self)
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    func modifyRecordSuccessAPI(_ result: APIModel<ResultModel>) {
        if result.isSuccess! {ScreenManager().goMainPages(1, self)}
        else {DialogManager().alertErrorDialog(result.message!, self)}
    }
}

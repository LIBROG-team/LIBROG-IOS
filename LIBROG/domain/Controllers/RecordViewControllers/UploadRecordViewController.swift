//
//  UploadRecordViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/09.
//

import UIKit
import Cosmos
import SwiftUI

class UploadRecordViewController: UIViewController {
    @IBOutlet weak var uploadRecordTableView: UITableView!
    @IBOutlet weak var completeButton: UIButton!
    
    let userId = UserDefaults.standard.string(forKey: "userId")
    var bookData: BookData!
    var starRating: Int!
    var quote: String!
    var content: String!
    
    var isCompleteButtonTap = false
    var isSuccess: Bool?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadRecordTableView.delegate = self
        uploadRecordTableView.dataSource = self
        
        uploadRecordTableView.separatorStyle = .none
        
        let uploadRecordNib = UINib(nibName: "UploadRecordTableViewCell", bundle: nil)
        uploadRecordTableView.register(uploadRecordNib, forCellReuseIdentifier: "UploadRecordTableViewCell")
        
        uploadRecordTableView.estimatedRowHeight = 500
        uploadRecordTableView.rowHeight = UITableView.automaticDimension
    }
    //MARK: 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // MARK: - Actions
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func completeButtonDidTap(_ sender: Any) {
        isCompleteButtonTap = true
        uploadRecordTableView.reloadData()
    }
}
// MARK: - 기록 추가 tableView delegate
extension UploadRecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UploadRecordTableViewCell", for: indexPath) as? UploadRecordTableViewCell else {
            return UITableViewCell()
        }
        if let bookData = self.bookData {cell.setBookData(bookData)}
        if isCompleteButtonTap == true {
            if let bookData = self.bookData {
                cell.postRecord(bookData, self)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
}
// MARK: API success
extension UploadRecordViewController {
    // MARK: 독서기록 추가 success
    func uploadRecordSuccessAPI(_ result: APIModel<UploadRecordModel>) {
        if result.isSuccess! {
            FlowerpotDataManager().addNewFlowerpotDataManager(self)
            ScreenManager().goMain(self)
        }
        else {DialogManager().alertErrorDialog(result.message!, self)}
    }
    // MARK: 조건에 맞는 화분 추가 api 호출 success
    func addNewFlowerpotSuccessAPI(_ result: APIModel<NewFlowerpotModel>) {
        print("조건에 맞는 화분 추가", result)
    }
}

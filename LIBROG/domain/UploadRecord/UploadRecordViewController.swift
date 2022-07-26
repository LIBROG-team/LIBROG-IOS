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
//    var bookTitle: String!
//    var author: [String]!
//    var publisher: String!
//    var publishedDate: String!
    var starRating: Int!
    var quote: String!
    var content: String!
    
    var isCompleteButtonTap = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadRecordTableView.delegate = self
        uploadRecordTableView.dataSource = self
        
        uploadRecordTableView.separatorStyle = .none
        
        let uploadRecordNib = UINib(nibName: "UploadRecordTableViewCell", bundle: nil)
        uploadRecordTableView.register(uploadRecordNib, forCellReuseIdentifier: "UploadRecordTableViewCell")
    }
    // MARK: - Actions
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func completeButtonDidTap(_ sender: Any) {
        isCompleteButtonTap = true
        uploadRecordTableView.reloadData()
    }
    @objc func quoteTextEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.quote = text
    }
}
extension UploadRecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UploadRecordTableViewCell", for: indexPath) as? UploadRecordTableViewCell else {
            return UITableViewCell()
        }
        cell.setBookData(self.bookData)
        if isCompleteButtonTap == true {
            cell.postRecord(self.bookData)
            goMain()
        }
        cell.quoteTextField.addTarget(self, action: #selector(quoteTextEditingChanged(_:)), for: .editingChanged)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 667
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard cell is MainFlowerTableViewCell else {
            return
        }
    }
}
extension UploadRecordViewController {
    func goMain() {
        // 첫화면으로 전환
        guard let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBarController") as? UITabBarController else {return}
        tabBarController.modalPresentationStyle = .fullScreen
        self.view.window?.windowScene?.keyWindow?.rootViewController = tabBarController
    }
}

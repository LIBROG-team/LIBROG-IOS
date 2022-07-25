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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadRecordTableView.delegate = self
        uploadRecordTableView.dataSource = self
        
        uploadRecordTableView.separatorStyle = .none
        
        let uploadRecordNib = UINib(nibName: "UploadRecordTableViewCell", bundle: nil)
        uploadRecordTableView.register(uploadRecordNib, forCellReuseIdentifier: "UploadRecordTableViewCell")
        
        //bookData 정의하기
        
    }
    // MARK: - Actions
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UploadRecordTableViewCell", for: indexPath) as? UplodaRecordTableViewCell else {
            return UITableViewCell()
        }
        cell.setBookData(self.bookData)
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

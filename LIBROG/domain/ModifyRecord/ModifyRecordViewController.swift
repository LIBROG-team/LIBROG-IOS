//
//  ModifyRecordViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/26.
//

import UIKit

class ModifyRecordViewController: UIViewController {
    @IBOutlet weak var modifyRecordTableView: UITableView!
    var recordData: ReadingRecordData!
    
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
}
extension ModifyRecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyRecordTableViewCell", for: indexPath) as? ModifyRecordTableViewCell else {
            return UITableViewCell()
        }
        cell.setRecordData(self.recordData)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 667
    }
}

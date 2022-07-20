//
//  ReadingRecordBottomViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/19.
//

import UIKit

class ReadingRecordBottomViewController: UIViewController {
    @IBOutlet weak var menuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.dataSource = self
        menuTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}
// MARK: - 독서기록 정렬 메뉴 Table view data source
extension ReadingRecordBottomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row == 0 { cell.textLabel?.text = "최근 기록 순" }
        else if indexPath.row == 1 { cell.textLabel?.text = "별점 높은 순" }
        else if indexPath.row == 2 { cell.textLabel?.text = "제목 순" }
        return cell
    }
    //셀 세로 길이 조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    //클릭 이벤트 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

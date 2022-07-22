//
//  NotAchievedFlowerpotSearchViewController2.swift
//  LIBROG
//
//  Created by gomin on 2022/07/22.
//

import UIKit

class NotAchievedFlowerPotSearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var notAchievedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.definesPresentationContext = true
        searchBar.delegate = self
        
        notAchievedTableView.delegate = self
        notAchievedTableView.dataSource = self

        let notAchievedNib = UINib(nibName: "NotAcheivedFlowerPotTableViewCell", bundle: nil)
        notAchievedTableView.register(notAchievedNib, forCellReuseIdentifier: "NotAcheivedFlowerPotTableViewCell")
    }
}
// MARK: - Table view data source
extension NotAchievedFlowerPotSearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
//        return tableView == resultVC.tableView ? fileteredData.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == notAchievedTableView) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotAcheivedFlowerPotTableViewCell", for: indexPath) as? NotAcheivedFlowerPotTableViewCell else { return UITableViewCell() }
//            cell.flowerPotNameLabel.text = fileteredData[indexPath.row].flowerPotName
            return cell
        }
        else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "검색창에 화분 이름을 입력해주세요"
            cell.textLabel?.textColor = UIColor.gray
            cell.textLabel?.textAlignment = .center
            cell.selectionStyle = .none
            return cell
        }
    }
    //셀 세로 길이 조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tableView == notAchievedTableView) {return 91}
        else {return view.frame.height}
    }
}
// MARK: - SearchBarDelegate
extension NotAchievedFlowerPotSearchViewController: UISearchBarDelegate {
    private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return }
        print("--> 검색어: \(searchTerm)")
    }
    
}

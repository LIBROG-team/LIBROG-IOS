//
//  AchievedFlowerPotViewController2.swift
//  LIBROG
//
//  Created by gomin on 2022/07/22.
//

import UIKit

class AchievedFlowerPotSearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var achievedTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.definesPresentationContext = true
        searchBar.delegate = self
        
        achievedTableView.delegate = self
        achievedTableView.dataSource = self

        let acheivedNib = UINib(nibName: "AcheivedFlowerPotTableViewCell", bundle: nil)
        achievedTableView.register(acheivedNib, forCellReuseIdentifier: "AcheivedFlowerPotTableViewCell")
        
        SwipeRecognizer().swipeRecognizer(self)
    }
}
// MARK: - Table view data source
extension AchievedFlowerPotSearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
//        return tableView == resultVC.tableView ? fileteredData.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == achievedTableView) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AcheivedFlowerPotTableViewCell", for: indexPath) as? AcheivedFlowerPotTableViewCell else { return UITableViewCell() }
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
        if(tableView == achievedTableView) {return 91}
        else {return view.frame.height}
    }
}
// MARK: - SearchBarDelegate
extension AchievedFlowerPotSearchViewController: UISearchBarDelegate {
    private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return }
        print("--> 검색어: \(searchTerm)")
    }
    
}

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
    var notAchievedFlowerpotArray: [NotAchievedSearchFlowerpotData]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.definesPresentationContext = true
        searchBar.delegate = self
        
        notAchievedTableView.delegate = self
        notAchievedTableView.dataSource = self

        let notAchievedNib = UINib(nibName: "NotAcheivedFlowerPotTableViewCell", bundle: nil)
        notAchievedTableView.register(notAchievedNib, forCellReuseIdentifier: "NotAcheivedFlowerPotTableViewCell")
        
        searchBarCustom()
    }
    //MARK: 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
// MARK: - Table view data source
extension NotAchievedFlowerPotSearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = notAchievedFlowerpotArray?.count ?? 0
        if count == 0 {return 1}
        else {return count}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let count = notAchievedFlowerpotArray?.count ?? 0
        if count == 0 {
            if searchBar.text == "" {
                let cell = UITableViewCell()
                cell.textLabel?.text = "검색창에 화분 이름을 입력해주세요"
                cell.textLabel?.font = UIFont(name: "Apple SD Gothic Neo", size: 14)
                cell.textLabel?.textColor = UIColor.gray
                cell.textLabel?.textAlignment = .center
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = UITableViewCell()
                cell.textLabel?.text = "검색 결과가 없습니다."
                cell.textLabel?.font = UIFont(name: "Apple SD Gothic Neo", size: 14)
                cell.textLabel?.textColor = UIColor.gray
                cell.textLabel?.textAlignment = .center
                cell.selectionStyle = .none
                return cell
            }
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotAcheivedFlowerPotTableViewCell", for: indexPath) as? NotAcheivedFlowerPotTableViewCell else { return UITableViewCell() }
            let itemIdx = indexPath.item
            if let flowerpot = self.notAchievedFlowerpotArray {
                // if data exists
                cell.setNotAchievedFlowerpotData(flowerpot[itemIdx])
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    //셀 세로 길이 조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let count = notAchievedFlowerpotArray?.count ?? 0
        if count == 0 {return notAchievedTableView.frame.height}
        else {return 91}
    }
}
// MARK: - SearchBarDelegate
extension NotAchievedFlowerPotSearchViewController: UISearchBarDelegate {
    private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    // MARK: searchBar Enter키 누를 때마다 호출
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return }
//        print("--> 검색어: \(searchTerm)")
        SearchDataManager().searchNotAchievedFlowerpotDataManager(searchTerm, self)
        notAchievedTableView.reloadData()
    }
    //MARK: searchBar custom
    func searchBarCustom() {
        let searchBarImage = UIImage()
        searchBar.backgroundImage = searchBarImage
        searchBar.setImage(UIImage(named: "search-green"), for: .search, state: .normal)

        //placeholder 커스텀
        let attributedString = NSMutableAttributedString(string: "화분 검색하기", attributes: [
                NSAttributedString.Key.font: UIFont(name: "Apple SD Gothic Neo", size: 15) as Any
            ])
        searchBar.searchTextField.attributedPlaceholder = attributedString
        searchBar.searchTextField.font = UIFont(name: "Apple SD Gothic Neo", size: 15)
        
        //cancel button
        searchBar.showsCancelButton = false
    }
}
//MARK: - 검색 success API
extension NotAchievedFlowerPotSearchViewController {
    func searchSuccessAPI(_ result: [NotAchievedSearchFlowerpotData]) {
        self.notAchievedFlowerpotArray = result
        notAchievedTableView.reloadData()
    }
    func searchFailAPI() {
        self.notAchievedFlowerpotArray = []
        notAchievedTableView.reloadData()
    }
}

//
//  AcheivedFlowerPotViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/12.
//

import UIKit

class AcheivedFlowerPotSearchViewController: UITableViewController , UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
//    var dataArray = [FlowerPotData]()
    
    var searchController = UISearchController()
    var resultVC = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
        searchController = UISearchController(searchResultsController: resultVC)
        
        tableView.tableHeaderView = searchController.searchBar
        //usally good to set the presentation context
        self.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        resultVC.tableView.delegate = self
        resultVC.tableView.dataSource = self

        let acheivedNib = UINib(nibName: "AcheivedFlowerPotTableViewCell", bundle: nil)
        resultVC.tableView.register(acheivedNib, forCellReuseIdentifier: "AcheivedFlowerPotTableViewCell")
        
        SwipeRecognizer().swipeRecognizer(self)
        searchBarCustom(searchController)
    }
    func updateSearchResults(for searchController: UISearchController) {
//        fileteredData = dataArray.filter({ (data:FlowerPotData) -> Bool in
//            return data.flowerPotName.lowercased().contains(searchController.searchBar.text!.lowercased())
//        })
        resultVC.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
//        return tableView == resultVC.tableView ? fileteredData.count : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == resultVC.tableView) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AcheivedFlowerPotTableViewCell", for: indexPath) as? AcheivedFlowerPotTableViewCell else { return UITableViewCell() }
//            cell.flowerPotNameLabel.text = fileteredData[indexPath.row].flowerPotName
            return cell
        }
        else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "화분 제목을 입력해주세요."
            cell.textLabel?.tintColor = UIColor.gray
            cell.textLabel?.textAlignment = .center
            cell.selectionStyle = .none
            return cell
        }
    }
    //셀 세로 길이 조절
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tableView == resultVC.tableView) {return 91}
        else {return view.frame.height}
    }
    
    private func setData(){
//        dataArray.append(FlowerPotData(flowerPotName: "One"))
//        dataArray.append(FlowerPotData(flowerPotName: "Two"))
//        dataArray.append(FlowerPotData(flowerPotName: "Three"))
//        dataArray.append(FlowerPotData(flowerPotName: "Ten"))
//        dataArray.append(FlowerPotData(flowerPotName: "Eleven"))
//        dataArray.append(FlowerPotData(flowerPotName: "Twelve"))
    }
    
    // MARK: - SearchBarDelegate
    private func dismissKeyboard() {
        searchController.searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        
        guard let searchTerm = searchController.searchBar.text,
              searchTerm.isEmpty == false else { return }
    }
    
    //MARK: searchBar custom
    func searchBarCustom(_ searchController: UISearchController) {
        //검색바 스크롤되지 않도록
        searchController.navigationItem.hidesSearchBarWhenScrolling = true

        let searchBarImage = UIImage()
        searchController.searchBar.backgroundImage = searchBarImage
        searchController.searchBar.setImage(UIImage(named: "search-green"), for: .search, state: .normal)

        
        //placeholder 커스텀
        let attributedString = NSMutableAttributedString(string: "화분 검색하기", attributes: [
                NSAttributedString.Key.font: UIFont(name: "Apple SD Gothic Neo", size: 15) as Any
            ])
        searchController.searchBar.searchTextField.attributedPlaceholder = attributedString
        
        //cancel button
        searchController.automaticallyShowsCancelButton = false
    }
}

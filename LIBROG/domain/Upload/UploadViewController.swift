//
//  UploadViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/07.
//

import UIKit

class UploadViewController: UITableViewController , UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate{
    //create the search controller and result contoller
    
    var dataArray = [Data]()
    var fileteredData = [Data]()
    
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
        let inputNib = UINib(nibName: "InputTableViewCell", bundle: nil)
        resultVC.tableView.register(inputNib, forCellReuseIdentifier: "InputTableViewCell")

        //MARK: - searchBar custom
        
        //검색바 스크롤되지 않도록
        searchController.navigationItem.hidesSearchBarWhenScrolling = true

        let searBarImage = UIImage()
        searchController.searchBar.backgroundImage = searBarImage
        
        //placeholder 커스텀
        searchController.searchBar.placeholder = "책 검색하기"
        let attributedString = NSMutableAttributedString(string: "책 검색하기", attributes: [
                NSAttributedString.Key.font: UIFont(name: "Apple SD Gothic Neo", size: 16) as Any
            ])
        searchController.searchBar.searchTextField.attributedPlaceholder = attributedString
        
        //cancel button
        searchController.automaticallyShowsCancelButton = false
        
    }

    func updateSearchResults(for searchController: UISearchController) {
        fileteredData = dataArray.filter({ (data:Data) -> Bool in
            return data.main.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
        resultVC.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == resultVC.tableView ? fileteredData.count : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == resultVC.tableView) {
            let cell = UITableViewCell()
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InputTableViewCell", for: indexPath) as? InputTableViewCell else { return UITableViewCell() }
            cell.textLabel?.text = fileteredData[indexPath.row].main
            return cell
        }
        else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "검색창에 책 제목을 입력해주세요."
            cell.textLabel?.textAlignment = .center
            cell.selectionStyle = .none
            return cell
        }
    }
    //셀 세로 길이 조절
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tableView == resultVC.tableView) {return 50}
        else {return 550}
    }
    
    private func setData(){
        dataArray.append(Data(main: "One", detail: .A))
        dataArray.append(Data(main: "Two", detail: .A))
        dataArray.append(Data(main: "Three", detail: .A))
        dataArray.append(Data(main: "Ten", detail: .B))
        dataArray.append(Data(main: "Eleven", detail: .B))
        dataArray.append(Data(main: "Twelve", detail: .B))
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
}

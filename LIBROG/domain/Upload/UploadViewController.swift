//
//  UploadViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/07.
//

import UIKit

class UploadViewController: UITableViewController {
    
    var dataArray = [Data]()
    
    var searchController = UISearchController()
    var resultVC = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: resultVC)
        tableView.tableHeaderView = searchController.searchBar
        
        self.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        resultVC.tableView.delegate = self
        resultVC.tableView.dataSource = self
        
        let inputNib = UINib(nibName: "InputTableViewCell", bundle: nil)
        resultVC.tableView.register(inputNib, forCellReuseIdentifier: "InputTableViewCell")
        
        searchBarCustom(searchController)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InputTableViewCell", for: indexPath) as? InputTableViewCell else { return UITableViewCell() }
        let cell = UITableViewCell()
        cell.textLabel?.text = dataArray[indexPath.row].main
        return cell
    }
    //셀 세로 길이 조절
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - SearchBarDelegate & SearchBar Custom
extension UploadViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    private func dismissKeyboard() {
        searchController.searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        
        guard let searchTerm = searchController.searchBar.text,
              searchTerm.isEmpty == false else { return }
    }
    //MARK: 입력값이 바뀔 때마다
    func updateSearchResults(for searchController: UISearchController) {
        dataArray.removeAll()
        SearchBookManager().searchBookManager(searchController.searchBar.searchTextField.text ?? " ", self)
        resultVC.tableView.reloadData()
    }
    //MARK: searchBar custom
    func searchBarCustom(_ searchController: UISearchController) {
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
}

// MARK: - 검색 성공 시
extension UploadViewController {
    func kakaoSearchBookSuccessAPI(_ result : [BookDetailModel]) {
        for book in result {
            dataArray.append(Data(main: book.title!, detail: .A))
        }
        resultVC.tableView.reloadData()
    }
}

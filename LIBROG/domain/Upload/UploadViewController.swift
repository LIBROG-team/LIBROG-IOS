//
//  UploadViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/07.
//

import UIKit

class UploadViewController: UITableViewController {
    
    var dataArray: [BookData] = []
    var searchWord = ""
    var pageNum = 1
    var searchCount = 0
    
    var searchController = UISearchController()
    var resultVC = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: resultVC)
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableHeaderView?.backgroundColor = .white
        
        self.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        resultVC.tableView.delegate = self
        resultVC.tableView.dataSource = self
        
        searchBarCustom(searchController)
//        tableView.backgroundColor = UIColor(named: "backgroundColor")
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchCount == 0 {return 1}
        else if self.searchCount <= 20 {return dataArray.count}
        else {return dataArray.count + 1}
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InputTableViewCell", for: indexPath) as? InputTableViewCell else { return UITableViewCell() }
        if dataArray.count == 0 {
            let cell = UITableViewCell()
            if searchController.searchBar.searchTextField.text == "" {
//                cell.imageView?.image = UIImage(named: "logo22%")
                cell.textLabel?.text = "검색창에 책 제목을 입력해주세요."
            } else {
                cell.textLabel?.text = "검색 결과가 없습니다."
            }
            cell.textLabel?.textColor = UIColor.gray
            cell.textLabel?.textAlignment = .center
            cell.selectionStyle = .none
            return cell
        }
        // 더보기 버튼 Custom
        if indexPath.row == dataArray.count {
            let cell = UITableViewCell()
            cell.textLabel?.text = "더보기"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = UIColor(named: "LIBROGColor")
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = UIColor(named: "LIBROGColor")?.cgColor
            cell.layer.cornerRadius = 10
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = dataArray[indexPath.row].bookTitle
            cell.backgroundColor = UIColor(named: "backgroundColor")
            if (indexPath.row == 0) {
                cell.layer.cornerRadius = 15
                cell.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)

            } else if (indexPath.row == dataArray.count-1) {
                cell.layer.cornerRadius = 15
                cell.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
            }
            return cell
        }
        
    }
    //셀 세로 길이 조절
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataArray.count == 0 {return resultVC.tableView.frame.height}
        if indexPath.row == dataArray.count {return 47}
        else {return 120}
    }
    //클릭 이벤트 처리
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // MARK: 더보기 버튼 클릭
        if indexPath.row == dataArray.count {
            pageNum = pageNum + 1
            SearchBookManager().searchBookManager(searchWord, pageNum, self)
        }
        // MARK: 셀 클릭
        else {
            guard let uploadRecordVC = UIStoryboard(name: "UploadRecord", bundle: nil).instantiateViewController(identifier: "UploadRecordVC") as? UploadRecordViewController else {return}
            let selectedBookData = dataArray[indexPath.item]
            uploadRecordVC.bookData = selectedBookData
            uploadRecordVC.modalPresentationStyle = .fullScreen
            self.present(uploadRecordVC, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
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
        pageNum = 1
        searchWord = searchController.searchBar.searchTextField.text ?? ""
        SearchBookManager().searchBookManager(searchWord, 1, self)
        resultVC.tableView.reloadData()
    }
    //MARK: searchBar custom
    func searchBarCustom(_ searchController: UISearchController) {
        //검색바 스크롤되지 않도록
        searchController.navigationItem.hidesSearchBarWhenScrolling = true

        let searchBarImage = UIImage()
        searchController.searchBar.backgroundImage = searchBarImage
        
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
    func kakaoSearchBookSuccessAPI(_ result : KakaoBookModel) {
        let bookData = result.documents
        for book in bookData {
            dataArray.append(BookData(bookTitle: book.title!, thumbnailURL: book.thumbnail!, author: book.authors, introduction: book.contents!, publisher: book.publisher!, publishedDate: book.datetime!))
        }
        self.searchCount = result.meta.pageable_count!
        resultVC.tableView.reloadData()
    }
}

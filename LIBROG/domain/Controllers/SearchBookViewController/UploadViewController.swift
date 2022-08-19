//
//  UploadViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/07.
//

import UIKit
import SnapKit

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
        searchController.searchBar.searchTextField.delegate = self
        
        resultVC.tableView.delegate = self
        resultVC.tableView.dataSource = self
        
        searchBarCustom(searchController)

        let kakaoBookNib = UINib(nibName: "ResultTableViewCell", bundle: nil)
        resultVC.tableView.register(kakaoBookNib, forCellReuseIdentifier: "ResultTableViewCell")
    }
    //MARK: 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 총 검색결과가 0이라면 '검색 결과가 없습니다'
        if self.searchCount == 0 {return 1}
        // 총 검색결과가 20개보다 적다면 검색결과만
        else if self.searchCount <= 20 {return dataArray.count}
        // 총 검색결과가 20개보다 많다면 마지막에 '더보기'버튼
        else {
            // 총 검색결과가 20개 보다 많지만 검색결과가 다 보여졌을 때
            if (self.searchCount <= dataArray.count) {return dataArray.count}
            // 검색결과가 덜 보여졌을 땐 마지막에 '더보기'버튼
            else {return dataArray.count + 1}
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataArray.count == 0 {
            setEmptyView()  //Empty View
            let cell = UITableViewCell()
            if searchController.searchBar.searchTextField.text != "" {
                cell.textLabel?.text = "검색 결과가 없습니다."
            }
            cell.textLabel?.font = UIFont(name: "Apple SD Gothic Neo", size: 14)
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as? ResultTableViewCell else { return UITableViewCell() }
            cell.kakaoBookData(dataArray[indexPath.row])
            cell.backgroundColor = UIColor(named: "backgroundColor")
            if (indexPath.row == 0) {
                if (dataArray.count == 1) {
                    cell.layer.cornerRadius = 15
                } else {
                    cell.layer.cornerRadius = 15
                    cell.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
                }
            } else if (indexPath.row == dataArray.count-1) {
                cell.layer.cornerRadius = 15
                cell.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
            } else {
                cell.layer.cornerRadius = 0
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
                NSAttributedString.Key.font: UIFont(name: "Apple SD Gothic Neo", size: 15) as Any
            ])
        searchController.searchBar.searchTextField.attributedPlaceholder = attributedString
        searchController.searchBar.searchTextField.font = UIFont(name: "Apple SD Gothic Neo", size: 15)
        
        //cancel button
        searchController.automaticallyShowsCancelButton = false
    }
}

// MARK: - 검색 성공 시
extension UploadViewController {
    func kakaoSearchBookSuccessAPI(_ result : KakaoBookModel) {
        let bookData = result.documents
        for book in bookData {
            guard let bookTitle = book.title else {return}
            guard let thumbnailURL = book.thumbnail else {return}
            guard let introduction = book.contents else {return}
            guard let publisher = book.publisher else {return}
            guard let publishedDate = book.datetime else {return}
            
            dataArray.append(BookData(bookTitle: bookTitle, thumbnailURL: thumbnailURL, author: book.authors, introduction: introduction, publisher: publisher, publishedDate: publishedDate))
        }
        self.searchCount = result.meta.pageable_count!
        resultVC.tableView.reloadData()
    }
}
// MARK: - Tableview BackView
extension UploadViewController {
    func setEmptyView() {
        let messageLabel = UILabel()
        messageLabel.font = UIFont(name: "Apple SD Gothic Neo", size: 14)
        messageLabel.textColor = .darkGray
        messageLabel.textAlignment = .center
        messageLabel.text = "검색창에 책 제목을 입력해주세요"
        messageLabel.sizeToFit()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo22%")
        imageView.contentMode = .scaleAspectFit
        
        let backgroudView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: self.tableView.bounds.height))
        backgroudView.addSubview(messageLabel)
        backgroudView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(113.0)
            make.trailing.equalToSuperview().inset(97.0)
            make.top.equalToSuperview().inset(219.0)
            make.bottom.equalTo(messageLabel.snp.top).offset(-25.0)
        }
        imageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        
        messageLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(198.0).priority(.low)
            make.centerX.equalToSuperview()
        }
        
        
        self.tableView.backgroundView = backgroudView

    }
}
extension UploadViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // TextField 비활성화
        return true
    }
}

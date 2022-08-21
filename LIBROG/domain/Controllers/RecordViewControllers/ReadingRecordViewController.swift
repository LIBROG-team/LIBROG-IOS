//
//  ReadingRecordViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/19.
//

import UIKit
import MaterialComponents.MaterialBottomSheet

class ReadingRecordViewController: UIViewController {
    @IBOutlet weak var readingRecordCollectionView: UICollectionView!
    @IBOutlet weak var filterButton: UIButton!
    
    let filterArray = ["최근 기록 순", "별점 높은 순", "제목 순"]
    let filterArrayUrl = ["recent", "rating", "title"]
    var bookArray: [ReadingRecordData]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        readingRecordCollectionView.delegate = self
        readingRecordCollectionView.dataSource = self
        
        let readingNib = UINib(nibName: "ReadingRecordCollectionViewCell", bundle: nil)
        readingRecordCollectionView.register(readingNib, forCellWithReuseIdentifier: ReadingRecordCollectionViewCell.identifier)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.minimumLineSpacing = 25.0
        
        readingRecordCollectionView.collectionViewLayout = flowLayout
        readingRecordCollectionView.reloadData()
        // 초기 화면은 '최근 기록 순' 정렬
        ReadingRecordDataManager().readingRecordFilterDataManager(filterArrayUrl[0], self)
    }
    override func viewDidAppear(_ animated: Bool) {
        // 선택된 정렬 필터에 따른 독서기록 보이기
        let filterStr = filterButton.titleLabel?.text
        for i in 0...2 {
            if filterStr! == filterArray[i] {ReadingRecordDataManager().readingRecordFilterDataManager(filterArrayUrl[i], self)}
        }
    }
    // MARK: - Actions
    @IBAction func scrollToTop_button(_ sender: Any) {
        readingRecordCollectionView.scrollToItem(at: IndexPath(item: -1, section: 0), at: .init(rawValue: 0), animated: true)
    }
    @IBAction func sorting_button(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ReadingRecordBottomVC") as! ReadingRecordBottomViewController
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
        self.present(bottomSheet, animated: true, completion: nil)
        vc.setTableViewDataSourceDelegate(dataSourceDelegate: self)

        // 아래로 드래그해도 안닫히게 하기
        bottomSheet.dismissOnDraggingDownSheet = false
        // 높이 
        bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = 177
        // 뒤에 배경 컬러
        bottomSheet.scrimColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.54)
    }
    
}
// MARK: -  독서기록 CollectionView delegate
extension ReadingRecordViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = bookArray?.count ?? 0
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: "ReadingRecordCollectionViewCell", for: indexPath) as? ReadingRecordCollectionViewCell else {
            return UICollectionViewCell()
        }
        let itemIdx = indexPath.item
        if let url = self.bookArray[itemIdx].bookImgUrl {
            // if data exists
            cell.setBookImg(url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 94, height: 140)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let recordDetailVC = UIStoryboard(name: "RecordDetail", bundle: nil).instantiateViewController(identifier: "RecordDetailVC") as? RecordDetailViewController else {return}
        let recordIdx = bookArray[indexPath.item].readingRecordIdx
        recordDetailVC.recordIdx = recordIdx
        
        recordDetailVC.modalPresentationStyle = .fullScreen
        self.present(recordDetailVC, animated: true, completion: nil)
    }
}
// MARK: -  독서기록 MDCBottomSheet delegate
extension ReadingRecordViewController: MDCBottomSheetControllerDelegate {
    func bottomSheetControllerDidDismissBottomSheet(_ controller: MDCBottomSheetController) {
        print("바트 시트 닫힘")
    }
    
    func bottomSheetControllerDidChangeYOffset(_ controller: MDCBottomSheetController, yOffset: CGFloat) {
        // 바텀 시트 위치
        print(yOffset)
    }
}
// MARK: - 독서기록 정렬 메뉴 Table view data source
extension ReadingRecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.contentInsetAdjustmentBehavior = .never
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont(name: "Apple SD Gothic Neo", size: 14)
        if indexPath.row == 0 { cell.textLabel?.text = filterArray[0] }
        else if indexPath.row == 1 { cell.textLabel?.text = filterArray[1] }
        else if indexPath.row == 2 { cell.textLabel?.text = filterArray[2] }
        return cell
    }
    //셀 세로 길이 조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    //클릭 이벤트 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 버튼 config 추가
        var config = UIButton.Configuration.plain()
        var attText = AttributedString.init(filterArray[0])
        // 독서기록 정렬 필터
        let tag = indexPath.row
        attText = AttributedString.init(filterArray[tag])
        ReadingRecordDataManager().readingRecordFilterDataManager(filterArrayUrl[tag], self)
        
        // config font & image 설정
        attText.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        config.attributedTitle = attText
        config.image = UIImage.init(named: "arrow-down")
        config.imagePlacement = .leading
        config.imagePadding = 5
        filterButton.configuration = config
        
        self.dismiss(animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
// MARK: - 독서기록 api success
extension ReadingRecordViewController {
    // MARK: 유저의 모든 독서기록 조회
    func userReadingRecordSuccessAPI(_ result: [ReadingRecordData]) {
        self.bookArray = result
        readingRecordCollectionView.reloadData()
    }
    //MARK: 독서기록 필터 정렬 API
    func userReadingRecordFilterSuccessAPI(_ result: [ReadingRecordData]) {
        if var bookArray = self.bookArray { bookArray.removeAll() }
        self.bookArray = result
        readingRecordCollectionView.reloadData()
    }
}


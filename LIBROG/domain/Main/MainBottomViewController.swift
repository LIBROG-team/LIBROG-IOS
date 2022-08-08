//
//  MainBottomViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/15.
//

import UIKit
import SafariServices

class MainBottomViewController: UIViewController {

    @IBOutlet weak var recentBookCollectionView: UICollectionView!
    @IBOutlet weak var todaySuggestCollectionView: UICollectionView!
    @IBOutlet weak var noticeCollectionView: UICollectionView!
    
    var recentBookArray: [RecentBookModel]!
    var noticeArray: [NoticeModel]!
    var recommendArray: [RecommendBookModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // collectionView delegate
        recentBookCollectionView.delegate = self
        recentBookCollectionView.dataSource = self
        todaySuggestCollectionView.delegate = self
        todaySuggestCollectionView.dataSource = self
        noticeCollectionView.delegate = self
        noticeCollectionView.dataSource = self
        
        let recentBookNib = UINib(nibName: "RecentBookCollectionViewCell", bundle: nil)
        recentBookCollectionView.register(recentBookNib, forCellWithReuseIdentifier: RecentBookCollectionViewCell.identifier)
        let todaySuggestionNib = UINib(nibName: "TodaySuggestCollectionViewCell", bundle: nil)
        todaySuggestCollectionView.register(todaySuggestionNib, forCellWithReuseIdentifier: TodaySuggestCollectionViewCell.identifier)
        let noticeNib = UINib(nibName: "NoticeCollectionViewCell", bundle: nil)
        noticeCollectionView.register(noticeNib, forCellWithReuseIdentifier: NoticeCollectionViewCell.identifier)
        
        MainPageDataManager().recentBookDataManager(self)
        MainPageDataManager().noticeDataManager(self)
        MainPageDataManager().recommendBookDataManager(self)
    }
}
// MARK: - 메인페이지의 하단 collectionView delegate
extension MainBottomViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == recentBookCollectionView) {
            let count = recentBookArray?.count ?? 0
            return count
        } else if(collectionView == todaySuggestCollectionView) {
            let count = recommendArray?.count ?? 0
            return count
        } else if(collectionView == noticeCollectionView) {
            let count = noticeArray?.count ?? 0
            return count
        } else {return 0}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // MARK: 최근 읽은 책 collectionView
        if(collectionView == recentBookCollectionView) {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentBookCollectionViewCell", for: indexPath) as? RecentBookCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.roundCornersDiffernt(topLeft: 8, topRight: 17, bottomLeft: 17, bottomRight: 17)
            let itemIdx = indexPath.item
            cell.setRecentBookData(recentBookArray[itemIdx])
            return cell
        }
        // MARK: 추천 도서 collectionView
        else if(collectionView == todaySuggestCollectionView) {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodaySuggestCollectionViewCell", for: indexPath) as? TodaySuggestCollectionViewCell else {
                return UICollectionViewCell()
            }
            let itemIdx = indexPath.item
            if let cellData = self.recommendArray {
                cell.setRecommendBook(cellData[itemIdx])
            }
            return cell
        }
        // MARK: 공지사항 collectionView
        else if(collectionView == noticeCollectionView) {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoticeCollectionViewCell", for: indexPath) as? NoticeCollectionViewCell else {
                return UICollectionViewCell()
            }
            let itemIdx = indexPath.item
            cell.setNotice(noticeArray[itemIdx])
//            print("NOTICE...",noticeArray[itemIdx])
            return cell
        }
        else {
            let cell = UICollectionViewCell()
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == recentBookCollectionView) { return CGSize(width: 193, height: 128) }
        else if(collectionView == todaySuggestCollectionView) { return CGSize(width: 120, height: 84) }
        else if(collectionView == noticeCollectionView) { return CGSize(width: 340, height: 56) }
        else  { return CGSize(width: 0, height: 0)}
    }
    // 셀 선택
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == noticeCollectionView) {
            // 공지사항 링크 이동
            let noticeUrlStr = noticeArray[indexPath.item].connectUrl!
            let noticeUrl = NSURL(string: noticeUrlStr)
            let noticeView: SFSafariViewController = SFSafariViewController(url: noticeUrl as! URL)
            self.present(noticeView, animated: true, completion: nil)
        }
        if(collectionView == todaySuggestCollectionView) {
            // 추천도서 링크 이동
            let recommendUrlStr = recommendArray[indexPath.item].connectUrl!
            let recommendUrl = NSURL(string: recommendUrlStr)
            let recommendView: SFSafariViewController = SFSafariViewController(url: recommendUrl as! URL)
            self.present(recommendView, animated: true, completion: nil)
        }
    }
}
// MARK: - API success
extension MainBottomViewController {
    // MARK: 유저의 최근 읽은 책 api
    func recentBookSuccessAPI(_ result: [RecentBookModel]) {
        self.recentBookArray = result
        recentBookCollectionView.reloadData()
    }
    // MARK: 활성화된 공지사항 api
    func noticeSuccessAPI(_ result: [NoticeModel]) {
        self.noticeArray = result
        noticeCollectionView.reloadData()
    }
    // MARK: 추천 책 api
    func recommendBookSuccessAPI(_ result: [RecommendBookModel]) {
        self.recommendArray = result
        todaySuggestCollectionView.reloadData()
    }
}

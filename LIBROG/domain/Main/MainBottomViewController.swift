//
//  MainBottomViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/15.
//

import UIKit

class MainBottomViewController: UIViewController {

    @IBOutlet weak var recentBookCollectionView: UICollectionView!
    @IBOutlet weak var todaySuggestCollectionView: UICollectionView!
    @IBOutlet weak var bottomBannerView: UIView!
    
    var recentBookArray: [RecentBookModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 최근 읽은 책 collectionView
        recentBookCollectionView.delegate = self
        recentBookCollectionView.dataSource = self
        todaySuggestCollectionView.delegate = self
        todaySuggestCollectionView.dataSource = self
        
        let recentBookNib = UINib(nibName: "RecentBookCollectionViewCell", bundle: nil)
        recentBookCollectionView.register(recentBookNib, forCellWithReuseIdentifier: RecentBookCollectionViewCell.identifier)
        let todaySuggestionNib = UINib(nibName: "TodaySuggestCollectionViewCell", bundle: nil)
        todaySuggestCollectionView.register(todaySuggestionNib, forCellWithReuseIdentifier: TodaySuggestCollectionViewCell.identifier)
        
        MainPageDataManager().recentBookDataManager(self)
    }
}
// MARK: - 메인페이지의 하단 collectionView delegate
extension MainBottomViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = recentBookArray?.count ?? 0
        return count
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
            cell.roundCornersDiffernt(topLeft: 8, topRight: 17, bottomLeft: 17, bottomRight: 17)
            return cell
        }
        else {
            let cell = UICollectionViewCell()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == recentBookCollectionView) { return CGSize(width: 193, height: 128) }
        else if(collectionView == todaySuggestCollectionView) { return CGSize(width: 120, height: 171) }
        else  { return CGSize(width: 0, height: 0)}
    }
}
// MARK: - 유저의 최근 읽은 책 가져오기 API success
extension MainBottomViewController {
    func recentBookSuccessAPI(_ result: [RecentBookModel]) {
        self.recentBookArray = result
    }
}

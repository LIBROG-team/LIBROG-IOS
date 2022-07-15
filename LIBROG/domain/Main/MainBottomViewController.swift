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
        
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .horizontal
//        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 29, bottom: 0, right: 0)
//        flowLayout.minimumLineSpacing = 9.0
//
//        recentBookCollectionView.collectionViewLayout = flowLayout
//        recentBookCollectionView.reloadData()
//        todaySuggestCollectionView.collectionViewLayout = flowLayout
//        todaySuggestCollectionView.reloadData()
    }
}
// MARK: - 메인페이지의 '최근 읽은 책' collectionView delegate
extension MainBottomViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let count = auctionNowArray?.count ?? 0
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == recentBookCollectionView) {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentBookCollectionViewCell", for: indexPath) as? RecentBookCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.roundCornersDiffernt(topLeft: 8, topRight: 17, bottomLeft: 17, bottomRight: 17)
            return cell
        }
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

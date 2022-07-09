//
//  MainViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/01.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var MainTableView: UITableView!
    @IBOutlet weak var recentBookView: UIView!
    @IBOutlet weak var recentBookCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MainTableView.delegate = self
        MainTableView.dataSource = self
        
        MainTableView.separatorStyle = .none
        
        let flowerNib = UINib(nibName: "MainFlowerTableViewCell", bundle: nil)
        MainTableView.register(flowerNib, forCellReuseIdentifier: "MainFlowerTableViewCell")
        
        // 최근 읽은 책 view 그림자
        recentBookView.roundCorners(cornerRadius: 18, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        recentBookView.layer.masksToBounds = false
        recentBookView.layer.shadowColor = UIColor.gray.cgColor
        recentBookView.layer.shadowOffset = CGSize(width: 0, height: -5)
        recentBookView.layer.shadowOpacity = 0.14
        recentBookView.layer.shadowRadius = 30.0
        
        // 최근 읽은 책 collectionView
        recentBookCollectionView.delegate = self
        recentBookCollectionView.dataSource = self
        
        let recentBookNib = UINib(nibName: "RecentBookCollectionViewCell", bundle: nil)
        recentBookCollectionView.register(recentBookNib, forCellWithReuseIdentifier: RecentBookCollectionViewCell.identifier)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 29, bottom: 0, right: 0)
        flowLayout.minimumLineSpacing = 9.0
        
        recentBookCollectionView.collectionViewLayout = flowLayout
        recentBookCollectionView.reloadData()
    }
}
// MARK: - 메인페이지 tableView delegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainFlowerTableViewCell", for: indexPath) as? MainFlowerTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 510
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard cell is MainFlowerTableViewCell else {
            return
        }
    }
}
// MARK: - 메인페이지의 '최근 읽은 책' collectionView delegate
extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let count = auctionNowArray?.count ?? 0
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentBookCollectionViewCell", for: indexPath) as? RecentBookCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.roundCornersDiffernt(topLeft: 8, topRight: 17, bottomLeft: 17, bottomRight: 17)
//        let itemIdx = indexPath.item
//        if let cellData = self.auctionNowArray {
//            // if data exists
//            cell.setUpData(cellData[itemIdx])
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 193, height: 128)
    }
    // COLLECTIONVIEW SELECT
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if UIManager().isLogin() {
//            let itemIdx = indexPath.item
//            getItemId(itemIdx)
//
//            guard let itemDetailViewController = self.storyboard?
//                    .instantiateViewController(withIdentifier: "ItemDetailVC")
//                    as? ItemDetailViewController else {return}
//            itemDetailViewController.itemId = self.cellItemId  //itemId
//            itemDetailViewController.modalPresentationStyle = .fullScreen
//            self.present(itemDetailViewController, animated: true, completion: nil)
//        } else {
//            UIManager().showToast(message: "로그인 후 이용 가능합니다.", viewController: self)
//        }
//    }
}
//extension HomeViewController {
//    func auctionNowSuccessAPI(_ result : AuctionNowModel) {
//        self.auctionNowArray = result.data
//        HomeTableView.reloadData()
//    }
//    func getItemId(_ index: Int) {
//        if let cellData = self.auctionNowArray {
//            // if data exists
//            cellItemId = cellData[index].id
//        }
//    }
//}


//
//  MainViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/01.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var MainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MainTableView.delegate = self
        MainTableView.dataSource = self
        
        MainTableView.separatorStyle = .none
        
        let flowerNib = UINib(nibName: "MainFlowerTableViewCell", bundle: nil)
        MainTableView.register(flowerNib, forCellReuseIdentifier: "MainFlowerTableViewCell")
        let recentNib = UINib(nibName: "RecentBookTableViewCell", bundle: nil)
        MainTableView.register(recentNib, forCellReuseIdentifier: "RecentBookTableViewCell")
    }
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainFlowerTableViewCell", for: indexPath) as? MainFlowerTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentBookTableViewCell", for: indexPath) as? RecentBookTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {return 510}
        else {return 216}
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            guard cell is MainFlowerTableViewCell else {
                return
            }
        } else {
            guard let recentBookTableViewCell = cell as? RecentBookTableViewCell else {
                return
            }
            recentBookTableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        }
    }
}
extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let count = auctionNowArray?.count ?? 0
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentBookCollectionViewCell", for: indexPath) as? RecentBookCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.roundCornersDiffernt(topLeft: 5, topRight: 53, bottomLeft: 53, bottomRight: 53)
//        let itemIdx = indexPath.item
//        if let cellData = self.auctionNowArray {
//            // if data exists
//            cell.setUpData(cellData[itemIdx])
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 151)
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


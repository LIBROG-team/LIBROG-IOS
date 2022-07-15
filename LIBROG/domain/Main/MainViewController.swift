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
        
//        // 최근 읽은 책 view 그림자
//        recentBookView.roundCorners(cornerRadius: 18, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
//        recentBookView.layer.masksToBounds = false
//        recentBookView.layer.shadowColor = UIColor.gray.cgColor
//        recentBookView.layer.shadowOffset = CGSize(width: 0, height: -5)
//        recentBookView.layer.shadowOpacity = 0.14
//        recentBookView.layer.shadowRadius = 30.0
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


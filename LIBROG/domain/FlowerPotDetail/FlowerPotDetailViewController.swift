//
//  FlowerPotDetailViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/12.
//

import UIKit
import WebKit

class FlowerPotDetailViewController: UIViewController {
    @IBOutlet weak var flowerPotImageView: UIImageView!
    @IBOutlet weak var flowerPotNameLabel: UILabel!
    @IBOutlet weak var flowerPotStartDateLabel: UILabel!
    @IBOutlet weak var flowerPotEndDateLabel: UILabel!
    @IBOutlet weak var bookCountLabel: UILabel!
    @IBOutlet weak var flowerPotNameGrowthLabel: UILabel!
    @IBOutlet weak var growthPointLabel: UILabel!
    @IBOutlet weak var growthProgessView: UIProgressView!
    @IBOutlet weak var recordBookCollectionView: UICollectionView!
    
    var flowerpotID: Int?
    var flowerpotName: String?
    var flowerpotImgUrl: String?
    var flowerpotStartDate: String?
    var flowerpotLastDate: String?
    var flowerpotReadCount: Int?
    var flowerpotExp: Int?
    
    var bookRecordArray: [FlowerpotBookRecordData]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 최근 읽은 책 collectionView
        recordBookCollectionView.delegate = self
        recordBookCollectionView.dataSource = self
        
        let bookNib = UINib(nibName: "FlowerPotDetailCollectionViewCell", bundle: nil)
        recordBookCollectionView.register(bookNib, forCellWithReuseIdentifier: FlowerPotDetailCollectionViewCell.identifier)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.minimumLineSpacing = 25.0
        
        recordBookCollectionView.collectionViewLayout = flowLayout
        recordBookCollectionView.reloadData()
        
        setFlowerpotData()
        FlowerpotBookRecordDataManager().getFlowerpotBookRecord(flowerpotID!, self)
    }
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    func setFlowerpotData() {
        flowerPotNameLabel.text = self.flowerpotName!
        flowerPotStartDateLabel.text = String(self.flowerpotStartDate!.split(separator: "T")[0])
        flowerPotEndDateLabel.text = String(self.flowerpotLastDate!.split(separator: "T")[0])
        bookCountLabel.text = String(self.flowerpotReadCount!)
        
        growthPointLabel.text = String(self.flowerpotExp!)
        // 화분 성장치 progressView
        let growth = Double(self.flowerpotExp!)
        growthPointLabel.text = String(Int(growth))
        UIView.animate(withDuration: 2) {
                    self.growthProgessView.setProgress(Float(growth * 0.0001), animated: true)
        }
        // 화분 이미지 출력
        if let url = URL(string: self.flowerpotImgUrl!) {
            flowerPotImageView.kf.setImage(with: url, placeholder: UIImage(named: "logo22%"))
        }
    }
}
// MARK: - 화분상세정보 페이지의 '화분에 기록된 책' collectionView delegate
extension FlowerPotDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = bookRecordArray?.count ?? 0
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlowerPotDetailCollectionViewCell", for: indexPath) as? FlowerPotDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        let itemIdx = indexPath.item
        if let url = self.bookRecordArray[itemIdx].imgUrl {
            // if data exists
            cell.setBookImg(url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 92, height: 136)
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
// MARK: - 유저의 화분에 기록된 책 정보 가져오기 API success
extension FlowerPotDetailViewController {
    func userFlowepotBookRecordSuccessAPI(_ result : [FlowerpotBookRecordData]) {
        self.bookRecordArray = result
        recordBookCollectionView.reloadData()
    }
}

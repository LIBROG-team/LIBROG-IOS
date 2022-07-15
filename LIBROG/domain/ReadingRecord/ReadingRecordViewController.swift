//
//  ReadingRecordViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/14.
//

import UIKit
import WebKit

class ReadingRecordViewController: UIViewController {
    @IBOutlet weak var ReadingRecordCollectionView: UICollectionView!
    @IBOutlet weak var sortPullDownButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReadingRecordCollectionView.delegate = self
        ReadingRecordCollectionView.dataSource = self
        
        let bookNib = UINib(nibName: "ReadingRecordCollectionViewCell", bundle: nil)
        ReadingRecordCollectionView.register(bookNib, forCellWithReuseIdentifier: ReadingRecordCollectionViewCell.identifier)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.minimumLineSpacing = 25.0
        
        ReadingRecordCollectionView.collectionViewLayout = flowLayout
        ReadingRecordCollectionView.reloadData()
    }
}
//MARK: - 독서기록 페이지의 책 사진 collectionView delegate
extension ReadingRecordViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReadingRecordCollectionViewCell", for: indexPath) as? ReadingRecordCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 94, height: 140)
    }
}

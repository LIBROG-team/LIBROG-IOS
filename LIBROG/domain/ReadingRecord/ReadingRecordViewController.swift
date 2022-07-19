//
//  ReadingRecordViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/19.
//

import UIKit

class ReadingRecordViewController: UIViewController {
    @IBOutlet weak var readingRecordCollectionView: UICollectionView!
    @IBAction func scrollToTop_button(_ sender: Any) {
        readingRecordCollectionView.scrollToItem(at: IndexPath(item: -1, section: 0), at: .init(rawValue: 0), animated: true)

    }
    @IBAction func sorting_button(_ sender: Any) {
        let bottomSheetVC = ReadingRecordBottomViewController()
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetVC, animated: false, completion: nil)

    }
    
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
    }

}

extension ReadingRecordViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: "ReadingRecordCollectionViewCell", for: indexPath) as? ReadingRecordCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 94, height: 140)
    }
}
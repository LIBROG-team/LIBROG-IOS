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
    @IBAction func scrollToTop_button(_ sender: Any) {
        readingRecordCollectionView.scrollToItem(at: IndexPath(item: -1, section: 0), at: .init(rawValue: 0), animated: true)
    }
    @IBAction func sorting_button(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ReadingRecordBottomVC") as! ReadingRecordBottomViewController
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
        self.present(bottomSheet, animated: true, completion: nil)

        // 아래로 드래그해도 안닫히게 하기
        bottomSheet.dismissOnDraggingDownSheet = false
        // 높이
        bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = 197
        // 뒤에 배경 컬러
        bottomSheet.scrimColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.54)
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
// MARK: -  독서기록 CollectionView delegate
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
// MARK: -  독서기록 정렬필터 선택 후 MDCBottomSheet delegate
extension ReadingRecordViewController: MDCBottomSheetControllerDelegate {
    func bottomSheetControllerDidDismissBottomSheet(_ controller: MDCBottomSheetController) {
        print("바트 시트 닫힘")
    }
    
    func bottomSheetControllerDidChangeYOffset(_ controller: MDCBottomSheetController, yOffset: CGFloat) {
        // 바텀 시트 위치
        print(yOffset)
    }
}

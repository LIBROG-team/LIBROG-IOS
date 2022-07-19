//
//  ReadingRecordViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/19.
//

import UIKit
import FloatingPanel

class ReadingRecordViewController: UIViewController {
    @IBOutlet weak var readingRecordCollectionView: UICollectionView!
    var fpc: FloatingPanelController!
    var readingRecordBottomVC: ReadingRecordBottomViewController! // 띄울 VC
    @IBAction func scrollToTop_button(_ sender: Any) {
        readingRecordCollectionView.scrollToItem(at: IndexPath(item: -1, section: 0), at: .init(rawValue: 0), animated: true)

    }
    @IBAction func sorting_button(_ sender: Any) {
        setupView()
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
    private func setupView() {
        readingRecordBottomVC = storyboard?.instantiateViewController(identifier: "ReadingRecordBottomVC", creator: { (coder) -> ReadingRecordBottomViewController? in
            return ReadingRecordBottomViewController(coder: coder)
        })
        fpc = FloatingPanelController()
//        fpc.changePanelStyle() // panel 스타일 변경 (대신 bar UI가 사라지므로 따로 넣어주어야함)
        fpc.delegate = self
        fpc.set(contentViewController: readingRecordBottomVC) // floating panel에 삽입할 것
        fpc.addPanel(toParent: self) // fpc를 관리하는 UIViewController
        fpc.layout = ReadingRecordFloatingPanelLayout()
        fpc.invalidateLayout() // if needed
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
// MARK: - FloatingPanel delegate
extension ReadingRecordViewController: FloatingPanelControllerDelegate {
    func floatingPanelDidChangePosition(_ fpc: FloatingPanelController) {
        if fpc.state == .full {

        } else {

        }
    }
}
// MARK: - Set floatingPanel state position
class ReadingRecordFloatingPanelLayout: FloatingPanelLayout {

    var position: FloatingPanelPosition {
        return .bottom
    }

    var initialState: FloatingPanelState {
        return .half
    }

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] { // 가능한 floating panel: 현재 full, half만 가능하게 설정
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 111.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 190, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}

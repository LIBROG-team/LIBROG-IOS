//
//  MainViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/01.
//

import UIKit
import FloatingPanel

class MainViewController: UIViewController {

    @IBOutlet weak var MainTableView: UITableView!
    
    var fpc: FloatingPanelController!
    var contentsVC: MainBottomViewController! // 띄울 VC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

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
    
    private func setupView() {
        contentsVC = storyboard?.instantiateViewController(identifier: "MainBottomVC", creator: { (coder) -> MainBottomViewController? in
            return MainBottomViewController(coder: coder)
        })
        fpc = FloatingPanelController()
        fpc.changePanelStyle() // panel 스타일 변경 (대신 bar UI가 사라지므로 따로 넣어주어야함)
        fpc.delegate = self
        fpc.set(contentViewController: contentsVC) // floating panel에 삽입할 것
//        fpc.track(scrollView: contentsVC.tbl)
        fpc.addPanel(toParent: self) // fpc를 관리하는 UIViewController
        fpc.layout = MyFloatingPanelLayout()
        fpc.invalidateLayout() // if needed
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

extension FloatingPanelController {
    func changePanelStyle() {
        let appearance = SurfaceAppearance()
        let shadow = SurfaceAppearance.Shadow()
        shadow.color = UIColor.darkGray
        shadow.offset = CGSize(width: 0, height: -5.0)
        shadow.opacity = 0.14
        shadow.radius = 30.0
        appearance.shadows = [shadow]
        appearance.cornerRadius = 18.0
        appearance.backgroundColor = .clear
        appearance.borderColor = .clear
        appearance.borderWidth = 0

        surfaceView.grabberHandle.isHidden = true
        surfaceView.appearance = appearance

    }
}
extension MainViewController: FloatingPanelControllerDelegate {
    func floatingPanelDidChangePosition(_ fpc: FloatingPanelController) {
        if fpc.state == .full {

        } else {

        }
    }
}
class MyFloatingPanelLayout: FloatingPanelLayout {

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

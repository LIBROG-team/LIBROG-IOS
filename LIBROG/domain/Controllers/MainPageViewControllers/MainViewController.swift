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
    var mainBottomVC: MainBottomViewController! // 띄울 VC
    
    var flowerpotData: MainPageFlowerpot?
    var dayCnt: Int?
    var mainMessage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        MainTableView.delegate = self
        MainTableView.dataSource = self
        
        MainTableView.separatorStyle = .none
        
        let flowerNib = UINib(nibName: "MainFlowerTableViewCell", bundle: nil)
        MainTableView.register(flowerNib, forCellReuseIdentifier: "MainFlowerTableViewCell")
        
        MainPageDataManager().mainPageFlowerpotDataManager(self)
        MainPageDataManager().mainPageDayCountDataManager(self)
    }
    override func viewDidAppear(_ animated: Bool) {
        MainPageDataManager().mainPageFlowerpotDataManager(self)
        MainPageDataManager().mainPageDayCountDataManager(self)
    }
    private func setupView() {
        mainBottomVC = storyboard?.instantiateViewController(identifier: "MainBottomVC", creator: { (coder) -> MainBottomViewController? in
            return MainBottomViewController(coder: coder)
        })
        fpc = FloatingPanelController()
        fpc.changePanelStyle() // panel 스타일 변경 (대신 bar UI가 사라지므로 따로 넣어주어야함)
        fpc.delegate = self
        fpc.set(contentViewController: mainBottomVC) // floating panel에 삽입할 것
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
        if let cellData = self.flowerpotData {
            // if data exists
            cell.setUpMainFlowerpotData(cellData)
        }
        if let dayCnt = self.dayCnt {cell.dayCnt = dayCnt}
        if let message = self.mainMessage {cell.mainMessage = message}
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
// MARK: - API success
extension MainViewController {
    //MARK: 유저의 화분 정보 가져오기 API success
    func userFlowerPotSuccessAPI(_ result : MainPageFlowerpot) {
        self.flowerpotData = result
        MainTableView.reloadData()
    }
    //MARK: 독서일차 & 문구 API success
    func userDayCountSuccessAPI(_ result : MainPageDayCountModel) {
        if let dayCnt = result.daycnt {self.dayCnt = dayCnt}
        if let message = result.content {self.mainMessage = message}
        MainTableView.reloadData()
    }
}
// MARK: - FloatingPanelController extension
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
// MARK: - FloatingPanel delegate
extension MainViewController: FloatingPanelControllerDelegate {
    func floatingPanelDidChangePosition(_ fpc: FloatingPanelController) {
        if fpc.state == .full {

        } else {

        }
    }
}
// MARK: - Set floatingPanel state position
class MyFloatingPanelLayout: FloatingPanelLayout {

    var position: FloatingPanelPosition {
        return .bottom
    }

    var initialState: FloatingPanelState {
        return .half
    }

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] { // 가능한 floating panel: 현재 full, half만 가능하게 설정
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 150.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 220, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}

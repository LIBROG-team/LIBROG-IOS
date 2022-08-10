//
//  MainViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/06/30.
//

import UIKit

class FlowerPotViewController: UIViewController {
    @IBOutlet weak var flowerpotTableView: UITableView!
    @IBOutlet weak var flowerpotCountLabel: UILabel!
    
    var flowerpotArray : [FlowerpotData]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flowerpotTableView.delegate = self
        flowerpotTableView.dataSource = self
        
        let flowerpotNib = UINib(nibName: "FlowerpotTableViewCell", bundle: nil)
        flowerpotTableView.register(flowerpotNib, forCellReuseIdentifier: "FlowerpotTableViewCell")
        
        FlowerpotDataManager().flowerpotDataManager(self)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        FlowerpotDataManager().flowerpotDataManager(self)
    }
    @IBAction func goToAddFlowerpotDidTap(_ sender: UIButton) {
        guard let addFlowerpotVC = UIStoryboard(name: "AddFlowerPot", bundle: nil).instantiateViewController(identifier: "AddFlowerPotVC") as? AddFlowerPotViewController else {return}
 
        addFlowerpotVC.modalPresentationStyle = .fullScreen
        self.present(addFlowerpotVC, animated: true, completion: nil)
    }
}
// MARK: - 화분 관리 페이지 tableView delegate
extension FlowerPotViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = flowerpotArray?.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FlowerpotTableViewCell", for: indexPath) as? FlowerpotTableViewCell else { return UITableViewCell()
        }
        let itemIdx = indexPath.item
        if let cellData = self.flowerpotArray {
            // if data exists
            cell.setFlowerpotData(cellData[itemIdx])
        }
        return cell
    }
    //셀 세로 길이 조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    //클릭 이벤트 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let userFlowerPotDetailVC = UIStoryboard(name: "UserFlowerPotDetail", bundle: nil).instantiateViewController(identifier: "UserFlowerPotDetailVC") as? FlowerPotDetailViewController else {return}
        // 화분 ID 넘기기
        userFlowerPotDetailVC.flowerpotID = flowerpotArray[indexPath.item].flowerPotIdx
        userFlowerPotDetailVC.flowerpotName = flowerpotArray[indexPath.item].name
        userFlowerPotDetailVC.flowerpotImgUrl = flowerpotArray[indexPath.item].flowerImgUrl
        userFlowerPotDetailVC.flowerpotStartDate = flowerpotArray[indexPath.item].startDate
        userFlowerPotDetailVC.flowerpotLastDate = flowerpotArray[indexPath.item].lastDate
        userFlowerPotDetailVC.flowerpotReadCount = flowerpotArray[indexPath.item].recordCount
        userFlowerPotDetailVC.flowerpotExp = flowerpotArray[indexPath.item].exp
        userFlowerPotDetailVC.flowerpotMaxExp = flowerpotArray[indexPath.item].maxExp
 
        userFlowerPotDetailVC.modalPresentationStyle = .fullScreen
        self.present(userFlowerPotDetailVC, animated: true, completion: nil)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
// MARK: - 유저의 화분 정보 가져오기 API success
extension FlowerPotViewController {
    func userFlowerPotSuccessAPI(_ result : [FlowerpotData]) {
        self.flowerpotArray = result
        flowerpotCountLabel.text = "총 " + String(flowerpotArray.count) + "권"
        flowerpotTableView.reloadData()
    }
}

//
//  AcheivedFlowerPotViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/18.
//

import UIKit

class AchievedFlowerPotViewController: UIViewController {

    @IBOutlet weak var acheivedFlowerPotTableView: UITableView!

    var achievedFlowerpotArray: [AddFlowerpotData]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        acheivedFlowerPotTableView.delegate = self
        acheivedFlowerPotTableView.dataSource = self

        let acheivedNib = UINib(nibName: "AcheivedFlowerPotTableViewCell", bundle: nil)
        acheivedFlowerPotTableView.register(acheivedNib, forCellReuseIdentifier: "AcheivedFlowerPotTableViewCell")

        AddFlowerpotDataManager().addAchievedFlowerpotDataManager(self)
    }

    }
// MARK: - 화분추가 '획득한 화분'탭 tableView delegate
extension AchievedFlowerPotViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = achievedFlowerpotArray?.count ?? 0
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AcheivedFlowerPotTableViewCell", for: indexPath) as? AcheivedFlowerPotTableViewCell else {
            return UITableViewCell()
        }
        let itemIdx = indexPath.item
        if let flowerpot = self.achievedFlowerpotArray {
            // if data exists
            cell.setAchievedFlowerpotData(flowerpot[itemIdx])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    //클릭 이벤트 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let flowerPotDescriptionVC = UIStoryboard(name: "FlowerPotDescription", bundle: nil).instantiateViewController(identifier: "FlowerPotDescriptionVC") as? FlowerPotDescriptionViewController else {return}
//        let selectedBookData = dataArray[indexPath.item]
//        uploadRecordVC.bookData = selectedBookData
        flowerPotDescriptionVC.modalPresentationStyle = .fullScreen
        self.present(flowerPotDescriptionVC, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
// MARK: - 유저의 획득한 화분 조회 API
extension AchievedFlowerPotViewController {
    func addFlowerpotAchievedSuccessAPI(_ result: [AddFlowerpotData]) {
        self.achievedFlowerpotArray = result
        acheivedFlowerPotTableView.reloadData()
    }
}


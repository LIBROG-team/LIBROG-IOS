//
//  NotAcheivedFlowerPotViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/18.
//

import UIKit

class NotAchievedFlowerPotViewController: UIViewController {
    @IBOutlet weak var notAcheivedFlowerPotTableView: UITableView!
    
    var notAchievedFlowerpotArray: [AddFlowerpotData]!

    override func viewDidLoad() {
        super.viewDidLoad()

        notAcheivedFlowerPotTableView.delegate = self
        notAcheivedFlowerPotTableView.dataSource = self

        let notAcheivedNib = UINib(nibName: "NotAcheivedFlowerPotTableViewCell", bundle: nil)
        notAcheivedFlowerPotTableView.register(notAcheivedNib, forCellReuseIdentifier: "NotAcheivedFlowerPotTableViewCell")
        
        AddFlowerpotDataManager().addNotAchievedFlowerpotDataManager(self)
    }
}
// MARK: - 화분추가 '미획득 화분'탭 tableView delegate
extension NotAchievedFlowerPotViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = notAchievedFlowerpotArray?.count ?? 0
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotAcheivedFlowerPotTableViewCell", for: indexPath) as? NotAcheivedFlowerPotTableViewCell else {
            return UITableViewCell()
        }
        let itemIdx = indexPath.item
        if let flowerpot = self.notAchievedFlowerpotArray {
            // if data exists
            cell.setNotAchievedFlowerpotData(flowerpot[itemIdx])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard cell is MainFlowerTableViewCell else {
            return
        }
    }
}
// MARK: - 유저의 미획득 화분 조회 API
extension NotAchievedFlowerPotViewController {
    func addFlowerpotNotAchievedSuccessAPI(_ result: [AddFlowerpotData]) {
        self.notAchievedFlowerpotArray = result
        notAcheivedFlowerPotTableView.reloadData()
    }
}

//
//  AcheivedFlowerPotViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/18.
//

import UIKit

class AchievedFlowerPotViewController: UIViewController {

    @IBOutlet weak var acheivedFlowerPotTableView: UITableView!

        override func viewDidLoad() {
            super.viewDidLoad()

            acheivedFlowerPotTableView.delegate = self
            acheivedFlowerPotTableView.dataSource = self

            let acheivedNib = UINib(nibName: "AcheivedFlowerPotTableViewCell", bundle: nil)
            acheivedFlowerPotTableView.register(acheivedNib, forCellReuseIdentifier: "AcheivedFlowerPotTableViewCell")

        }

    }
// MARK: - 화분추가 '획득한 화분'탭 tableView delegate
extension AchievedFlowerPotViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AcheivedFlowerPotTableViewCell", for: indexPath) as? AcheivedFlowerPotTableViewCell else {
            return UITableViewCell()
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

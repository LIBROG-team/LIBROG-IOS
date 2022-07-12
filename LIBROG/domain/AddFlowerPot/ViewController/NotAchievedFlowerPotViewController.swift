//
//  NotAchievedFlowerPotViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/12.
//

import UIKit

class NotAchievedFlowerPotViewController: UIViewController {
    @IBOutlet weak var notAcheivedFlowerPotTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notAcheivedFlowerPotTableView.delegate = self
        notAcheivedFlowerPotTableView.dataSource = self
        
        let notAcheivedNib = UINib(nibName: "NotAcheivedFlowerPotTableViewCell", bundle: nil)
        notAcheivedFlowerPotTableView.register(notAcheivedNib, forCellReuseIdentifier: "NotAcheivedFlowerPotTableViewCell")
    }
}
// MARK: - 화분추가 '미획득 화분'탭 tableView delegate
extension NotAchievedFlowerPotViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotAcheivedFlowerPotTableViewCell", for: indexPath) as? NotAcheivedFlowerPotTableViewCell else {
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

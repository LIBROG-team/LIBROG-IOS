//
//  MainViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/06/30.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let flowerpotNib = UINib(nibName: "FlowerpotTableViewCell", bundle: nil)
        tableView.register(flowerpotNib, forCellReuseIdentifier: "FlowerpotTableViewCell")
        tableView.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FlowerpotTableViewCell", for: indexPath) as? FlowerpotTableViewCell else { return UITableViewCell()
            
        }
        return cell
    }
    
//    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
//        tableview.clipsToBounds = true
//        tableview.layer.cornerRadius = cornerRadius
//        tableview.layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
//    }
    
    //셀 세로 길이 조절
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 340
//    }

}

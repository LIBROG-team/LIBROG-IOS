//
//  ReadingRecordBottomViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/19.
//

import UIKit

class ReadingRecordBottomViewController: UIViewController {
    @IBOutlet weak var menuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setTableViewDataSourceDelegate(dataSourceDelegate: UITableViewDataSource & UITableViewDelegate) {
        menuTableView.delegate = dataSourceDelegate
        menuTableView.dataSource = dataSourceDelegate
    }
}

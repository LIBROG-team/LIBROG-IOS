//
//  RegisterProfileBottomViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/28.
//

import UIKit

class RegisterProfileBottomViewController: UIViewController {
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

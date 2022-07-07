//
//  ExistSearchViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/07.
//

import UIKit

class ExistSearchViewController: UIViewController {
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var bookSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultTableView.delegate = self
        resultTableView.dataSource = self
        
        let existSearchNib = UINib(nibName: "ExistSearchTableViewCell", bundle: nil)
        resultTableView.register(existSearchNib, forCellReuseIdentifier: "ExistSearchTableViewCell")
        
        // Do any additional setup after loading the view.
    }
    
    //스크롤바
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resultTableView.flashScrollIndicators()
    }

}

extension ExistSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExistSearchTableViewCell", for: indexPath) as? ExistSearchTableViewCell else { return UITableViewCell()
        }
        return cell
    }
    
    //셀 세로 길이 조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}


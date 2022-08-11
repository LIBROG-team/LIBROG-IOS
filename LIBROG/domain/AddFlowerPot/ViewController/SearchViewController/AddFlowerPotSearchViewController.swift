//
//  AddFlowerPotSearchViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/18.
//

import UIKit

class AddFlowerPotSearchViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    var isAddFlowerpot: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        if isAddFlowerpot {self.navigationItem.title = "화분추가"}
        else {self.navigationBar.topItem?.title = "식물도감"}
    }
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}

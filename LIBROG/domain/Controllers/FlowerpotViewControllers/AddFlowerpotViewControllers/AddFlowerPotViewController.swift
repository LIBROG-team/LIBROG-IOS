//
//  AddFlowerPotViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/12.
//

import UIKit
import Tabman
import Pageboy

class AddFlowerPotViewController: TabmanViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    var isAddFlowerpot: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        if isAddFlowerpot {self.navigationItem.title = "화분추가"}
        else {self.navigationBar.topItem?.title = "식물도감"}
    }
    @IBAction func searchButtonDidTap(_ sender: UIBarButtonItem) {
        guard let flowerpotSearchViewController = self.storyboard?
                            .instantiateViewController(withIdentifier: "AddFlowerPotSearchVC")
                            as? AddFlowerPotSearchViewController else {return}
        flowerpotSearchViewController.isAddFlowerpot = self.isAddFlowerpot!
        
        flowerpotSearchViewController.modalPresentationStyle = .fullScreen
        self.present(flowerpotSearchViewController, animated: true, completion: nil)
    }
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

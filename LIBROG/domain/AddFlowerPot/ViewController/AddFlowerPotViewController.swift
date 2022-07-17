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

        override func viewDidLoad() {
            super.viewDidLoad()

        }
    @IBAction func searchButtonDidTap(_ sender: UIBarButtonItem) {
        guard let flowerpotSearchViewController = self.storyboard?
                            .instantiateViewController(withIdentifier: "AddFlowerPotSearchVC")
                            as? AddFlowerPotSearchViewController else {return}
        flowerpotSearchViewController.modalPresentationStyle = .fullScreen
        self.present(flowerpotSearchViewController, animated: true, completion: nil)
    }
}

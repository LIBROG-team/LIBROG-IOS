//
//  ViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/06/30.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tabBarVc = CustomTabBarController()

        let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainVC")
        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RecordVC")
        let vc3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "UploadVC")
        let vc4 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FlowerPotVC")
        let vc5 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProfileVC")
        vc1.title = "Main"
        vc2.title = "Record"
        vc3.title = "Upload"
        vc4.title = "FlowerPot"
        vc5.title = "Profile"
        
        tabBarVc.setViewControllers([vc1,vc2,vc3,vc4,vc5], animated: false)
        tabBarVc.tabBar.backgroundColor = .white
        tabBarVc.tabBar.layer.cornerRadius = 10
        tabBarVc.tabBar.tintColor = UIColor(named: "LIBROGColor")

        guard let items = tabBarVc.tabBar.items else {
            return
        }

        let images = ["homekit","message","","square.split.1x2","person"]
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }

        tabBarVc.modalPresentationStyle = .fullScreen
        self.present(tabBarVc, animated: false, completion: nil)
    }
}


//
//  CustomTabBarController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/01.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let controller1 = UIViewController()
        controller1.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        let nav1 = UINavigationController(rootViewController: ViewController())

        viewControllers = [nav1]
        setupMiddleButton()
    }

    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 61, height: 61))
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 50
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 45, weight: .semibold))
        menuButton.contentMode = .scaleAspectFill
        //shadows
        menuButton.layer.shadowColor = UIColor.black.cgColor
        menuButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        menuButton.layer.shadowOpacity = 0.5
        //
        menuButton.setImage(image, for: .normal)
        menuButton.tintColor = .white
        menuButton.layer.cornerRadius = menuButtonFrame.height
        view.addSubview(menuButton)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        view.layoutIfNeeded()
    }


    // MARK: - Actions

    @objc private func menuButtonAction(sender: UIButton) {
//        selectedIndex = 2
        let vc3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "UploadVC")
//        vc3.modalPresentationStyle = .fullScreen
        self.present(vc3, animated: true, completion: nil)
//        let vc = UploadViewController()
//        vc.modalPresentationStyle = .automatic
//        present(vc, animated: true, completion: nil)
    }

}

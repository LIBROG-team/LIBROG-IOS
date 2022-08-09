//
//  ScreenManager.swift
//  LIBROG
//
//  Created by gomin on 2022/08/08.
//

import Foundation
import UIKit

class ScreenManager {
    func goMain(_ viewcontroller: UIViewController) {
        // 첫화면으로 전환
        guard let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBarController") as? UITabBarController else {return}
        tabBarController.modalPresentationStyle = .fullScreen
        viewcontroller.view.window?.windowScene?.keyWindow?.rootViewController = tabBarController
    }
}
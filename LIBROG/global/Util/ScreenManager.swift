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
    func alertErrorDialog(_ errorMessage: String, _ viewcontroller: UIViewController) {
        let alert = UIAlertController(title: errorMessage, message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alert.addAction(ok)
        viewcontroller.present(alert, animated: true, completion: nil)
    }
    func emailSendSuccessDialog(_ message: String, _ subMessage: String, _ viewcontroller: UIViewController) {
        let alert = UIAlertController(title: message, message: subMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel) {action in
            guard let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(identifier: "LoginVC") as? LoginViewController else {return}
            loginVC.modalPresentationStyle = .fullScreen
            viewcontroller.view.window?.windowScene?.keyWindow?.rootViewController = loginVC
        }
        alert.addAction(ok)
        viewcontroller.present(alert, animated: true, completion: nil)
    }
    func alertQuitDialog(_ dialogTitle: String, _ viewcontroller: UIViewController) {
        let alert = UIAlertController(title: dialogTitle, message: "", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "네", style: .destructive) { action in
            // 탈퇴 코드
        }
        let cancel = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(confirm)
        viewcontroller.present(alert, animated: true, completion: nil)
    }
}

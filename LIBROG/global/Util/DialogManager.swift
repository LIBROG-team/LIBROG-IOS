//
//  DialogManager.swift
//  LIBROG
//
//  Created by gomin on 2022/08/14.
//

import Foundation
import UIKit

class DialogManager {
    // MARK: 일반 알림 창 (확인)
    func alertErrorDialog(_ errorMessage: String, _ viewcontroller: UIViewController) {
        let alert = UIAlertController(title: errorMessage, message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alert.addAction(ok)
        viewcontroller.present(alert, animated: true, completion: nil)
    }
    // MARK: 이메일 전송 알림 창 (제목, 부제목, 확인)
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
    // MARK: 유저 탈퇴 창 (제목, 네, 아니요)
    func alertQuitDialog(_ dialogTitle: String, _ viewcontroller: UIViewController) {
        let alert = UIAlertController(title: dialogTitle, message: "", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "네", style: .destructive) { action in
            // 탈퇴 코드
            SettingDataManager().userDeleteDataManager(viewcontroller as! SettingViewController)
        }
        let cancel = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        viewcontroller.present(alert, animated: true, completion: nil)
    }
}

//
//  RegisterTermViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/28.
//

import UIKit
import DLRadioButton

class RegisterTermViewController: UIViewController {
    @IBOutlet weak var goNextButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var privacyRadioButton: DLRadioButton!
    @IBOutlet weak var privacyTermTextView: UITextView!
    @IBOutlet weak var serviceRadioButton: DLRadioButton!
    @IBOutlet weak var serviceTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        warningLabel.isHidden = true
        
        goNextButton.layer.borderColor = UIColor.lightGray.cgColor
        goNextButton.layer.borderWidth = 1
        goNextButton.layer.cornerRadius = 20
        goNextButton.tintColor = UIColor.lightGray
        
        privacyTermTextView.cornerRadius = 5
        serviceTextView.cornerRadius = 5
        
        privacyRadioButton.isMultipleSelectionEnabled = true
        serviceRadioButton.isMultipleSelectionEnabled = true
        privacyRadioButton.tintColor = UIColor(named: "LIBROGColor")
        serviceRadioButton.tintColor = UIColor(named: "LIBROGColor")
    }
    //MARK: Actions
    @IBAction func privacyRadioButtonDidTap(_ sender: DLRadioButton) {isRadioButtonsSelected()}
    @IBAction func serviceRadioButtonDidTap(_ sender: DLRadioButton) {isRadioButtonsSelected()}
    
    // [다음] 버튼
    @IBAction func goNextButtonDidTap(_ sender: UIButton) {
        if privacyRadioButton.isSelected && serviceRadioButton.isSelected {
            guard let registerVC = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(identifier: "RegisterVC") as? RegisterViewController else {return}
            registerVC.modalPresentationStyle = .fullScreen
            self.present(registerVC, animated: true, completion: nil)
        } else {
            warningLabel.isHidden = false
        }
    }
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func isRadioButtonsSelected() {
        if privacyRadioButton.isSelected && serviceRadioButton.isSelected {
            goNextButton.layer.borderColor = UIColor(named: "LIBROGColor")?.cgColor
            goNextButton.tintColor = UIColor(named: "LIBROGColor")
            warningLabel.isHidden = true
        } else {
            goNextButton.layer.borderColor = UIColor.lightGray.cgColor
            goNextButton.tintColor = UIColor.lightGray
            warningLabel.isHidden = false
        }
    }
}

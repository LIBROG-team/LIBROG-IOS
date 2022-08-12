//
//  RegisterTermTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/08/13.
//

import UIKit
import DLRadioButton

class RegisterTermTableViewCell: UITableViewCell {
    @IBOutlet weak var goNextButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var privacyRadioButton: DLRadioButton!
    @IBOutlet weak var serviceRadioButton: DLRadioButton!
    
    var isEnable = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        warningLabel.isHidden = true
        ScreenManager().setLibrogButton(goNextButton)
    
        privacyRadioButton.isMultipleSelectionEnabled = true
        serviceRadioButton.isMultipleSelectionEnabled = true
        privacyRadioButton.tintColor = UIColor.white
        serviceRadioButton.tintColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func isRadioButtonsSelected() {
        if privacyRadioButton.isSelected && serviceRadioButton.isSelected {
            goNextButton.layer.borderColor = UIColor(named: "LIBROGColor")?.cgColor
            goNextButton.tintColor = UIColor(named: "LIBROGColor")
            warningLabel.isHidden = true
        } else {
            goNextButton.layer.borderColor = UIColor.lightGray.cgColor
            goNextButton.tintColor = UIColor.lightGray
        }
    }
    //MARK: Actions
    @IBAction func privacyRadioButtonDidTap(_ sender: DLRadioButton) {isRadioButtonsSelected()}
    @IBAction func serviceRadioButtonDidTap(_ sender: DLRadioButton) {isRadioButtonsSelected()}
    // [다음] 버튼
    @IBAction func goNextButtonDidTap(_ sender: UIButton) {
        if privacyRadioButton.isSelected && serviceRadioButton.isSelected {
            isEnable = true
        } else {
            isEnable = false
            warningLabel.isHidden = false
        }
    }
}

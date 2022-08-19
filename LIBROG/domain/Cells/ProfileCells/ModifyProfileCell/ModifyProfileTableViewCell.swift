//
//  ModifyProfileTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/08/14.
//

import UIKit

class ModifyProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var modifyButton: UIButton!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var introTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // 수정완료 버튼 Custom
        modifyButton.layer.borderColor = UIColor(named: "LIBROGColor")?.cgColor
        modifyButton.layer.borderWidth = 1
        modifyButton.layer.cornerRadius = 20
        modifyButton.tintColor = UIColor(named: "LIBROGColor")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

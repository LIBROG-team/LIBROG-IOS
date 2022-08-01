//
//  ProfileFlowerpotTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/08/01.
//

import UIKit

class ProfileFlowerpotTableViewCell: UITableViewCell {
    @IBOutlet weak var flowerpotButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 버튼 Custom
        flowerpotButton.layer.borderColor = UIColor(named: "LIBROGColor")?.cgColor
        flowerpotButton.layer.borderWidth = 1
        flowerpotButton.layer.cornerRadius = 10
        flowerpotButton.tintColor = UIColor(named: "LIBROGColor")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

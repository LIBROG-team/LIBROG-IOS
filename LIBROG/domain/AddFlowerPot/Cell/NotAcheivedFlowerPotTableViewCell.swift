//
//  NotAcheivedFlowerPotTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/07/12.
//

import UIKit

class NotAcheivedFlowerPotTableViewCell: UITableViewCell {
    @IBOutlet weak var flowerPotNameLabel: UILabel!
    @IBOutlet weak var flowerPotRequestLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setNotAchievedFlowerpotData(_ cellData: AddFlowerpotData) {
        flowerPotNameLabel.text = cellData.name!
    }
}

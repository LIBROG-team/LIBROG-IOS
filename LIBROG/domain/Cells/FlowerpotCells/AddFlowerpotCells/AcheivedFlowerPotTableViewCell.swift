//
//  AcheivedFlowerPotTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/07/12.
//

import UIKit

class AcheivedFlowerPotTableViewCell: UITableViewCell {
    @IBOutlet weak var flowerPotImageView: UIImageView!
    @IBOutlet weak var flowerPotNameLabel: UILabel!
    @IBOutlet weak var flowerPotDateLabel: UILabel!
    @IBOutlet weak var flowerTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setAchievedFlowerpotData(_ cellData: AddFlowerpotData) {
        if let flowerpotName = cellData.name {flowerPotNameLabel.text = flowerpotName}
        if let flowerpotDate = cellData.bloomingPeriod { flowerPotDateLabel.text = "예상 " + flowerpotDate }
        if let flowerpotType = cellData.type { flowerTypeLabel.text = flowerpotType }
        if let flowerpotImgUrl = cellData.flowerImgUrl {
            flowerPotImageView.kf.setImage(with: URL(string: flowerpotImgUrl), placeholder: UIImage(named: "logo_launchScreen_white"))
        }
    }
}

//
//  FlowerPotDescriptionTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/07/16.
//

import UIKit

class FlowerPotDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var flowerNameLabel: UILabel!
    @IBOutlet weak var flowerNameEnglishLabel: UILabel!
    @IBOutlet weak var flowerImageView: UIImageView!
    @IBOutlet weak var flowerDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setFlowerpotData(_ data: FlowerpotDescriptionData) {
        if let flowerName = data.name {flowerNameLabel.text = flowerName}
        if let flowerNameEng = data.engName {flowerNameEnglishLabel.text = flowerNameEng}
        if let flowerDescription = data.content {flowerDescriptionLabel.text = flowerDescription}
        if let url = data.flowerImgUrl {
            flowerImageView.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "logo_launchScreen_white"))
        }
    }
}

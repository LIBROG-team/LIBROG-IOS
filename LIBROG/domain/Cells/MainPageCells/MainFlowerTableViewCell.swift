//
//  MainFlowerTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/07/01.
//

import UIKit

class MainFlowerTableViewCell: UITableViewCell {
    @IBOutlet weak var bookDateLabel: UILabel!
    @IBOutlet weak var mainMessageLabel: UILabel!
    @IBOutlet weak var flowerImageView: UIImageView!
    @IBOutlet weak var flowerNameLabel: UILabel!
    
    var dayCnt: Int?
    var mainMessage: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func setUpMainFlowerpotData(_ cellData: MainPageFlowerpot) {
        if let flowerpotName = cellData.name {flowerNameLabel.text = flowerpotName}
        if let imgUrlStr = cellData.flowerImgUrl {
            flowerImageView.kf.setImage(with: URL(string: imgUrlStr), placeholder: UIImage(named: "logo_launchScreen_white"))
        }
        if let backgroundColor = cellData.backgroundColor {flowerImageView.backgroundColor = UIColor(hex: backgroundColor)}
        if let dayCnt = self.dayCnt {bookDateLabel.text = "독서 \(dayCnt)일차"}
        mainMessageLabel.text = self.mainMessage
    }
    public func setUpMainPageLabelData() {
        
    }
}

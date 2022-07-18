//
//  MainFlowerTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/07/01.
//

import UIKit

class MainFlowerTableViewCell: UITableViewCell {

    @IBOutlet weak var bookDateLabel: UILabel!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    @IBOutlet weak var flowerNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func setUpData(_ cellData: FlowerpotData) {
//            let imgBaseURL = "https://hup-bucket.s3.ap-northeast-2.amazonaws.com/"
            
        guard let flowerpotName = cellData.name else {return}
        guard let imgUrlStr = cellData.flowerImgUrl else {return}
        
        flowerNameLabel.text = flowerpotName
        if let url = URL(string: imgUrlStr) {
            flowerImageView.kf.setImage(with: url, placeholder: UIImage(named: "logo22%"))
        }
    }
    
}

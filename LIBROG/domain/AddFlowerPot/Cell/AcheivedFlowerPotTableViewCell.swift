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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

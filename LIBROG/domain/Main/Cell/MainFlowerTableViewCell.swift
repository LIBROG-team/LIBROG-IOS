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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

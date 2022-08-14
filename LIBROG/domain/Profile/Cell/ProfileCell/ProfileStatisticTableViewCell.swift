//
//  ProfileStatisticTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/08/01.
//

import UIKit

class ProfileStatisticTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setProfileMenu(_ imgStr: String, _ menu: String, _ count: Int, _ unit: String) {
            menuLabel.text = menu
            countLabel.text = String(count)
            unitLabel.text = unit
            iconImageView.image = UIImage(named: imgStr)
            
        }
}

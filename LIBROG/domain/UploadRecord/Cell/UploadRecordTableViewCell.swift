//
//  UplodaRecordTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/07/09.
//

import UIKit
import Cosmos

class UplodaRecordTableViewCell: UITableViewCell {

    @IBOutlet weak var bookPointView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // 별점 초기 설정
        bookPointView.rating = 4
        // Show only fully filled stars
        bookPointView.settings.fillMode = .full
        
//        // Other fill modes: .half, .precise
//        // Change the size of the stars
//        bookPointView.settings.starSize = 22
//        // Set the distance between stars
//        bookPointView.settings.starMargin = 5
//        // Set the color of a filled star
//        bookPointView.settings.filledColor = UIColor(named: "LIBROGColor")!
//        // Set the border color of an empty star
//        bookPointView.settings.emptyBorderColor = UIColor.black
//        // Set the border color of a filled star
//        bookPointView.settings.filledBorderColor = UIColor.black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

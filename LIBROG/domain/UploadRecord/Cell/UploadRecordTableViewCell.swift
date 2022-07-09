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
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

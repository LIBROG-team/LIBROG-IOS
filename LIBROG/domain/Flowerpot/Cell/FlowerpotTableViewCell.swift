//
//  FlowerpotTableViewCell.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/01.
//

import UIKit

class FlowerpotTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewFlowerpot: UIImageView!
    @IBOutlet weak var labelFlowerName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelBookNum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //imageViewFloewerpot border
        imageViewFlowerpot.clipsToBounds = true
        imageViewFlowerpot.roundCornersDiffernt(topLeft: 10, topRight: 40, bottomLeft: 40, bottomRight: 40)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        // 테이블 뷰 셀 사이의 간격
        super.layoutSubviews()
        
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
//        contentView.backgroundColor = .white
//        contentView.layer.cornerRadius = 15
    }
    
}

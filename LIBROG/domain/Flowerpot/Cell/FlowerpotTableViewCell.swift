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
    
    var flowerpotData: FlowerpotData!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //imageViewFloewerpot border
        imageViewFlowerpot.clipsToBounds = true
        imageViewFlowerpot.roundCornersDiffernt(topLeft: 10, topRight: 40, bottomLeft: 40, bottomRight: 40)
        
        setFlowerpotData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        // 테이블 뷰 셀 사이의 간격
        super.layoutSubviews()
    }
    func setFlowerpotData() {
        labelFlowerName.text = self.flowerpotData.name
        let startDate = self.flowerpotData.startDate!
        let lastDate = self.flowerpotData.lastDate!
        labelDate.text = startDate + "~" + lastDate
        labelBookNum.text = "기록된 권수: " + String(self.flowerpotData.recordCount!)
        
        // 화분 이미지 출력
        if let url = URL(string: self.flowerpotData.flowerImgUrl!) {
            imageViewFlowerpot.kf.setImage(with: url, placeholder: UIImage(named: "logo22%"))
        }
    }
}

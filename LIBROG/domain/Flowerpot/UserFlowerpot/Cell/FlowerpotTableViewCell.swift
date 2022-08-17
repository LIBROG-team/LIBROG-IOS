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
//        imageViewFlowerpot.roundCornersDiffernt(topLeft: 10, topRight: 40, bottomLeft: 40, bottomRight: 40)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    // MARK: 테이블뷰의 셀이 재사용되기 전 호출되는 함수
    // 여기서 property들을 초기화해준다.
    override func prepareForReuse() {
        super.prepareForReuse()

        imageViewFlowerpot.image = UIImage()
        imageViewFlowerpot.backgroundColor = nil
        labelFlowerName.text = nil
        labelDate.text = nil
        labelBookNum.text = nil
    }
    override func layoutSubviews() {
        // 테이블 뷰 셀 사이의 간격
        super.layoutSubviews()
    }
    func setFlowerpotData(_ data: FlowerpotData) {
        labelFlowerName.text = data.name!
        let startDate = data.startDate!.split(separator: "T")[0]
        let lastDate = data.lastDate!.split(separator: "T")[0]
        labelDate.text = startDate + " ~ " + lastDate
        labelBookNum.text = "기록된 권수: " + String(data.recordCount!) + "권"
        
        // 화분 이미지 출력
        if let url = URL(string: data.flowerImgUrl!) {
            imageViewFlowerpot.kf.setImage(with: url, placeholder: UIImage(named: "logo22%"))
        }
        if let backgroundColor = data.backgroundColor {imageViewFlowerpot.backgroundColor = UIColor(hex: backgroundColor)}
    }
}

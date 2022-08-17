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
    public func setUpMainFlowerpotData(_ cellData: MainPageFlowerpot) {
        if let flowerpotName = cellData.name {flowerNameLabel.text = flowerpotName}
        if let imgUrlStr = cellData.flowerImgUrl {
            flowerImageView.kf.setImage(with: URL(string: imgUrlStr), placeholder: UIImage(named: "logo_launchScreen_white"))
        }
        if let backgroundColor = cellData.backgroundColor {flowerImageView.backgroundColor = UIColor(hex: backgroundColor)}
//        // 날짜 계산 (독서 00일차)
////        let startDateStrWithNoT = startDateStr.replacingOccurrences(of: "T", with: " ")
//        let startDateStrWithNoT = String(startDateStr.split(separator: "T")[0])
//        let startDate = startDateStrWithNoT.toDate()
//        let offsetComps = Calendar.current.dateComponents([.year,.month,.day], from: startDate!, to: Date())
//        if case let (y?, m?, d?) = (offsetComps.year, offsetComps.month, offsetComps.day) {
//            print("\(y)년 \(m)월 \(d)일 만큼 차이남")
//            bookDateLabel.text = "독서 \(d)일차"
//        }
    }
    public func setUpMainPageLabelData() {
        
    }
}

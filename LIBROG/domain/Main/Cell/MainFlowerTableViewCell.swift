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
        
        guard let startDateStr = cellData.startDate else {return}
        guard let flowerpotName = cellData.name else {return}
        guard let imgUrlStr = cellData.flowerImgUrl else {return}
         
        flowerNameLabel.text = flowerpotName // 꽃 이름
        // 꽃 이미지 출력
        if let url = URL(string: imgUrlStr) {
            flowerImageView.kf.setImage(with: url, placeholder: UIImage(named: "logo22%"))
        }
        // 날짜 계산 (독서 00일차)
        let startDateStrWithNoT = startDateStr.replacingOccurrences(of: "T", with: " ")
        let startDate = startDateStrWithNoT.toDate()!
        let offsetComps = Calendar.current.dateComponents([.year,.month,.day], from: startDate, to: Date())
        if case let (y?, m?, d?) = (offsetComps.year, offsetComps.month, offsetComps.day) {
            print("\(y)년 \(m)월 \(d)일 만큼 차이남")
            bookDateLabel.text = "독서 \(d)일차"
        }
    }
    
}

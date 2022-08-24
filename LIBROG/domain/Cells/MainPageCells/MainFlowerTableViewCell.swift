//
//  MainFlowerTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/07/01.
//

import UIKit
import Kingfisher

class MainFlowerTableViewCell: UITableViewCell {
    @IBOutlet weak var bookDateLabel: UILabel!
    @IBOutlet weak var mainMessageLabel: UILabel!
    @IBOutlet weak var flowerImageView: UIImageView!
    @IBOutlet weak var flowerNameLabel: UILabel!
    
    var dayCnt: Int?
    var mainMessage: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: 테이블뷰의 셀이 재사용되기 전 호출되는 함수
    // 여기서 property들을 초기화해준다.
    override func prepareForReuse() {
        super.prepareForReuse()

        flowerNameLabel.text = nil
        mainMessageLabel.text = nil
        bookDateLabel.text = nil
        flowerImageView.image = UIImage()
        
        let cache = ImageCache.default
        cache.clearMemoryCache()
        cache.clearDiskCache()
    }
    public func setUpMainFlowerpotData(_ cellData: MainPageFlowerpot) {
        if let flowerpotName = cellData.name {flowerNameLabel.text = flowerpotName}
        if let imgUrlStr = cellData.flowerImgUrl {
            flowerImageView.kf.setImage(with: URL(string: imgUrlStr), placeholder: UIImage(named: "logo_launchScreen_white"))
        }
        if let backgroundColor = cellData.backgroundColor {flowerImageView.backgroundColor = UIColor(hex: backgroundColor)}
        if let dayCnt = self.dayCnt {bookDateLabel.text = "독서 \(dayCnt)일차"}
        mainMessageLabel.text = self.mainMessage
    }
    public func setUpMainPageLabelData() {
        
    }
}

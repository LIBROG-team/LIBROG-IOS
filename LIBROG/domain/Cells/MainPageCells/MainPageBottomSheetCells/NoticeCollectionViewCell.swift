//
//  NoticeCollectionViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/08/03.
//

import UIKit

class NoticeCollectionViewCell: UICollectionViewCell {
    static let identifier = "NoticeCollectionViewCell"
    
    @IBOutlet weak var noticeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setNotice(_ result: NoticeModel) {
        // 공지사항 이미지 출력
        guard let noticeImg = result.noticeImgUrl else {return}
        if let url = URL(string: noticeImg) {
            noticeImageView.kf.setImage(with: url, placeholder: UIImage())
        }
    }
}

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
    // MARK: 테이블뷰의 셀이 재사용되기 전 호출되는 함수
    // 여기서 property들을 초기화해준다.
    override func prepareForReuse() {
        super.prepareForReuse()

        noticeImageView.image = UIImage()
    }
    func setNotice(_ result: NoticeModel) {
        // 공지사항 이미지 출력
        guard let noticeImg = result.noticeImgUrl else {return}
        if let url = URL(string: noticeImg) {
            noticeImageView.kf.setImage(with: url, placeholder: UIImage())
        }
    }
}

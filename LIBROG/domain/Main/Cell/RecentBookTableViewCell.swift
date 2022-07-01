//
//  RecentBookTableViewCell.swift
//  LIBROG
//
//  Created by gomin on 2022/07/01.
//

import UIKit

class RecentBookTableViewCell: UITableViewCell {
    @IBOutlet weak var recentBookCollectionView: UICollectionView!
    @IBOutlet weak var recentBookLabel: PaddingLabel!
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDelegate & UICollectionViewDataSource, forRow row: Int) {
        recentBookCollectionView.delegate = dataSourceDelegate
        recentBookCollectionView.dataSource = dataSourceDelegate
        recentBookCollectionView.tag = row
        
        let recentBookNib = UINib(nibName: "RecentBookCollectionViewCell", bundle: nil)
        recentBookCollectionView.register(recentBookNib, forCellWithReuseIdentifier: RecentBookCollectionViewCell.identifier)
        
        recentBookLabel.roundCorners(cornerRadius: 10, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        flowLayout.minimumLineSpacing = 12.0
        
        recentBookCollectionView.collectionViewLayout = flowLayout
        recentBookCollectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

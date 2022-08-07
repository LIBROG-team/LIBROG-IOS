//
//  FlowerPotDescriptionViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/16.
//

import UIKit

class FlowerPotDescriptionViewController: UIViewController {

    @IBOutlet weak var flowerPotDetailTableView: UITableView!
    
    var flowerpotID: Int?
    var flowerpotListId: Int!
    var flowerpotData: FlowerpotDescriptionData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 최근 읽은 책 collectionView
        flowerPotDetailTableView.delegate = self
        flowerPotDetailTableView.dataSource = self
        
        flowerPotDetailTableView.separatorStyle = .none
        
        let flowerPotNib = UINib(nibName: "FlowerPotDescriptionTableViewCell", bundle: nil)
        flowerPotDetailTableView.register(flowerPotNib, forCellReuseIdentifier: "FlowerPotDescriptionTableViewCell")
        
        FlowerpotDescriptionDataManager().getFlowerpotDescriptionDataManager(self.flowerpotID!, self)
    }
    @IBAction func addAcqFlowerpotButtonDidTap(_ sender: UIButton) {
        if let idx = self.flowerpotListId {
            FlowerpotDescriptionDataManager().addAcqFlowerpotDataManager(idx, self)
        }
    }
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
// MARK: - 화분 상세 페이지 tableView delegate
extension FlowerPotDescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FlowerPotDescriptionTableViewCell", for: indexPath) as? FlowerPotDescriptionTableViewCell else {
            return UITableViewCell()
        }
        if let data = self.flowerpotData {
            cell.setFlowerpotData(data)
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height
    }
}
// MARK: - API success
extension FlowerPotDescriptionViewController {
    // MARK: 화분 상세 정보 조회 API
    func flowerpotDescriptionSuccessAPI(_ result : FlowerpotDescriptionData) {
        self.flowerpotData = result
        flowerPotDetailTableView.reloadData()
    }
    //MARK: 획득 화분에서 화분 추가 API
    func addAcqFlowerpotSuccessAPI() {
//        goMain()
//        print("")
    }
}

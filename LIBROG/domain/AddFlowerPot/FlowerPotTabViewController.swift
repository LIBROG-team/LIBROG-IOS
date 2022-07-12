//
//  TabManViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/12.
//

import UIKit
import Tabman
import Pageboy

class FlowerPotTabViewController: TabmanViewController {

    private var viewControllers: Array<UIViewController> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AcheivedFlowerpotVC")
        let vc3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NotAcheivedFlowerpotVC")
            
        viewControllers.append(vc2)
        viewControllers.append(vc3)
        
        self.dataSource = self

        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize

        // Add to view
        addBar(bar, dataSource: self, at: .top)
        }
}
// MARK: - 상단 탭 TM delegate
extension FlowerPotTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        item.title = "Page \(index)"
//        item.image = UIImage(named: "image.png")
        // ↑↑ 이미지는 이따가 탭바 형식으로 보여줄 때 사용할 것이니 "이미지가 왜 있지?" 하지말고 넘어가주세요.
        
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

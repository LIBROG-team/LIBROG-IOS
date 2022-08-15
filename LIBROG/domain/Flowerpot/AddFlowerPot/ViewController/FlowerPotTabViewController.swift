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

        let AcheivedFlowerpotVC = UIStoryboard(name: "AcheivedFlowerPot", bundle: nil).instantiateViewController(identifier: "AcheivedFlowerpotVC")
        let NotAcheivedFlowerpotVC = UIStoryboard(name: "NotAcheivedFlowerPot", bundle: nil).instantiateViewController(identifier: "NotAcheivedFlowerpotVC")

        viewControllers.append(AcheivedFlowerpotVC)
        viewControllers.append(NotAcheivedFlowerpotVC)
        
        self.dataSource = self

        // 바 생성 + tabbar 에 관한 디자인처리를 여기서 하면 된다.
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize
        // tab indicator 속성
        bar.indicator.tintColor = UIColor(named: "LIBROGColor")
        bar.indicator.overscrollBehavior = .bounce
        bar.indicator.weight = .custom(value: 1)
        // tap center
        bar.layout.alignment = .centerDistributed
        // tab 사이 간격
        bar.layout.interButtonSpacing = 114
        // tab 배경색
        bar.backgroundView.style = .flat(color: .white)
        // tap 선택 / 미선택
        bar.buttons.customize { (button) in
            button.tintColor = .gray
            button.selectedTintColor = .black
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        }

        // bar를 안보이게 하고 싶으면 addBar를 지우면 된다. at -> bar 위치
        addBar(bar, dataSource: self, at: .top)
    }
}
// MARK: - 상단 탭 TM delegate
extension FlowerPotTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        let tabTitle: String = index == 0 ? "획득한 화분" : "미획득 화분"
        item.title = tabTitle
        
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

//
//  SwipeRecognizer.swift
//  LIBROG
//
//  Created by gomin on 2022/07/21.
//

import Foundation
import UIKit

class SwipeRecognizer {
    var viewcontroller: UIViewController!
    
    func swipeRecognizer(_ viewcontroller: UIViewController) {
        self.viewcontroller = viewcontroller
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        viewcontroller.view?.addGestureRecognizer(swipeRight)
    }
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                case UISwipeGestureRecognizer.Direction.right:
                viewcontroller.dismiss(animated: true, completion: nil)
                default: break
            }

        }
    }
}

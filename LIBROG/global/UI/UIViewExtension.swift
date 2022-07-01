//
//  UIViewExtension.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/01.
//

import Foundation
import UIKit

extension UIView {
    // View의 모서리 전체에 radius값 주기
    @IBInspectable var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    // View의 특정 모서리만 radius값 주기
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}

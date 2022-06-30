//
//  UIViewExtension.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/01.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}

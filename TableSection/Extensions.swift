//
//  Extensions.swift
//  TableSection
//
//  Created by yingcan on 17/3/9.
//  Copyright © 2017年 guoxuan. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    //旋转
    func rotate(toValue:CGFloat,duration:CFTimeInterval = 0.2) {
        let animation = CABasicAnimation.init(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey: nil)
    }
}

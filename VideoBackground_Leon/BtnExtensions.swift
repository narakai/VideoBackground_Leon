//
//  BtnExtensions.swift
//  VideoBackground_Leon
//
//  Created by lai leon on 2017/9/4.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit
import Foundation

extension UIButton {
    func customBtn(customTitle title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
    }
}

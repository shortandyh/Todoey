//
//  UIViewExtension.swift
//  Todoey
//
//  Created by stone_1 on 16/02/2020.
//  Copyright © 2020 stone1. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.8).cgColor, UIColor.black.withAlphaComponent(0.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

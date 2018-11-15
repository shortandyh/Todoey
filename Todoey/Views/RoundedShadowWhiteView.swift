//
//  RoundedShadowWhiteView.swift
//  Todoey
//
//  Created by stone_1 on 12/11/2018.
//  Copyright © 2018 stone1. All rights reserved.
//

import UIKit

class RoundedShadowWhiteView: UIImageView {
        
        override func awakeFromNib() {
            self.layer.shadowColor = UIColor.white.cgColor
            self.layer.shadowRadius = 10
            self.layer.shadowOpacity = 1
            self.layer.cornerRadius = self.frame.height / 80
//            self.layer.borderColor = UIColor.white.cgColor
//            self.layer.borderWidth = 1
            self.clipsToBounds = true
        }
        
}


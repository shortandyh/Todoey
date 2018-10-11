//
//  RoundedShadowButton.swift
//  PicNPlace
//
//  Created by stone_1 on 22/08/2018.
//  Copyright © 2018 stone1. All rights reserved.
//

import UIKit

class RoundedShadowButton: UIButton {

    override func awakeFromNib() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 15
        self.layer.shadowOpacity = 0.75
        self.layer.cornerRadius = self.frame.height / 6
        self.clipsToBounds = true
    }

}

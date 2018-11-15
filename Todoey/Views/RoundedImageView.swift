//
//  RoundedImageView.swift
//  PicNPlace
//
//  Created by stone_1 on 22/08/2018.
//  Copyright © 2018 stone1. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {

    override func awakeFromNib() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 50
        self.layer.shadowOpacity = 1
        self.layer.cornerRadius = self.layer.frame.height / 24
        self.clipsToBounds = true
    }

}

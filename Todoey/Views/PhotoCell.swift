//
//  PhotoCell.swift
//  Todoey
//
//  Created by stone_1 on 12/10/2018.
//  Copyright © 2018 stone1. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var savedPhotoView: UIImageView!
    @IBOutlet weak var photoLabel: UILabel!
    
    override func awakeFromNib() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 3.0, height: 6.0)
        self.layer.cornerRadius = self.layer.frame.height / 24
        
    }
    
    
//    func updateViews(item: Item) {
//        
//        savedPhotoView.image = item.itemImageURL
//        photoLabel.text = item.title
//        
//    }
    
}

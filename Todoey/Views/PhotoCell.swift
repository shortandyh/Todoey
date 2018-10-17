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
    
    
    func updateViews(item: Item) {
        let image = UIImage(data: item.itemImage!)
        savedPhotoView.image = image
        photoLabel.text = item.title
        
    }
    
}

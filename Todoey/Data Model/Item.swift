//
//  Item.swift
//  Todoey
//
//  Created by stone_1 on 20/10/2018.
//  Copyright © 2018 stone1. All rights reserved.
//

import Foundation
import RealmSwift
import Toucan

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var itemImageURL: String = ""
    @objc dynamic var itemThumbImageURL: String = ""
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
    convenience init(image : UIImage) {
        self.init()
        var imgNum = Int()
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            let fileCount = fileURLs.count
            if fileCount != 0 {
                imgNum = fileCount + 1
            } else {
                print("Nothing here")
            }
        } catch {
            print("Error whileenumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
      
        title = ("Pic\(imgNum)")
        itemImageURL = imageToURLString(image: image)
        if let smallImage = Toucan(image: image).resize(CGSize(width: 500, height: 500), fitMode: .scale).image{
            itemThumbImageURL = imageToURLString(image: smallImage)
        }
        
    }
    
    func fullImage() -> UIImage {
        return imageWithFilename(filename: itemImageURL)
    }
    
    func thumbnailImage() -> UIImage {
        return imageWithFilename(filename: itemThumbImageURL)
    }
    
    func imageWithFilename(filename: String) -> UIImage {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        path.appendingPathComponent(filename)
        if let imageData = try? Data(contentsOf: path) {
            if let image = UIImage(data: imageData) {
                return image
            }
        }
        return UIImage()
    }
    
    func imageToURLString(image: UIImage) -> String {
        if let imageData = UIImagePNGRepresentation(image) {
            let fileName = UUID().uuidString + ".png"
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            path.appendingPathComponent(fileName)
            try? imageData.write(to: path)
            return fileName
        }
        return ""
    }
}

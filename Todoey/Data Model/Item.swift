//
//  Item.swift
//  Todoey
//
//  Created by stone_1 on 20/10/2018.
//  Copyright © 2018 stone1. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var itemImage = Data()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

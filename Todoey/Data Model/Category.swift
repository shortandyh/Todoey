//
//  Category.swift
//  Todoey
//
//  Created by stone_1 on 20/10/2018.
//  Copyright © 2018 stone1. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}



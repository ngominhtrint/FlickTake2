//
//  Favorite.swift
//  MovieViewer
//
//  Created by TriNgo on 7/11/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit
import RealmSwift

class Favorite: Object {

    dynamic var id: Int = 0
    dynamic var isFavorite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

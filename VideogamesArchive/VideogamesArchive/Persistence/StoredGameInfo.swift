//
//  StoredGameInfo.swift
//  VideogamesArchive
//
//  Created by Rigoberto Saenz on 1/3/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import RealmSwift

class StoredGameInfo: Object {
    var id: Int = 0
    var name: String = ""
    var url: String = ""
    var summary: String?
    var storyline: String?
    var rating: Float?
    var screenshots: [String]?
    var cover: String?
}

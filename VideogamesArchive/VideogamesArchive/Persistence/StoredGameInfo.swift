//
//  StoredGameInfo.swift
//  VideogamesArchive
//
//  Created by Rigoberto Saenz on 1/3/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import RealmSwift

class StoredGameInfo: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var url: String?
    @objc dynamic var summary: String?
    @objc dynamic var storyline: String?
    @objc dynamic var rating: Float = 0
    let screenshots = List<String>()
    @objc dynamic var cover: String?
}

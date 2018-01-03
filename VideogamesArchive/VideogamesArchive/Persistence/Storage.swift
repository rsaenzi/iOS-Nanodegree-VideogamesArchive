//
//  Storage.swift
//  VideogamesArchive
//
//  Created by Rigoberto Saenz on 1/3/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import Foundation
import RealmSwift

class Storage {
    
    static let shared = Storage()
    
    private lazy var realm: Realm = {
        let realm: Realm
        do {
            realm = try Realm()
            
        } catch let error as NSError {
            fatalError("Persistent Storage object can not be created. Error: \(error)")
        }
        return realm
    }()
    
    func save(gameInfo: StoredGameInfo) {
        realm.add(gameInfo)
    }
    
    func delete(gameInfo: StoredGameInfo) {
        realm.delete(gameInfo)
    }
    
    func getGameInfo(id: Int) -> StoredGameInfo? {
        return realm.objects(StoredGameInfo.self).filter("id == %d", id).first
    }
}

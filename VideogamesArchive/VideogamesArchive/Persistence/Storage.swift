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
            fatalError("Realm instance can not be created. Error: \(error)")
        }
        return realm
    }()
    
    func save(gameInfo: GameInfo) {
        
        do {
            try realm.write {
                
                let objectToStore = realm.create(StoredGameInfo.self)
                objectToStore.id = gameInfo.id
                objectToStore.name = gameInfo.name
                objectToStore.url = gameInfo.url
                objectToStore.summary = gameInfo.summary
                objectToStore.storyline = gameInfo.storyline
                
                if let validRating = gameInfo.rating {
                    objectToStore.rating = validRating
                }
                
                if let validScreenshots = gameInfo.screenshots {
                    for image in validScreenshots {
                        objectToStore.screenshots.append(image.url)
                    }
                }
                
                if let validCover = gameInfo.cover {
                    objectToStore.cover = validCover.url
                }
            }
        } catch {
            print("Write operation could not be performed. Error: \(error)")
        }
    }
    
    func getAllGames() -> [GameInfo] {
        
        let games = realm.objects(StoredGameInfo.self)
        
        var results = [GameInfo]()
        for item in games {
            results.append(GameInfo(from: item))
        }
        return results
    }
    
    func getGameInfo(id: Int) -> GameInfo? {
        
        let predicate = NSPredicate(format: "id = %d", id)
        let results = realm.objects(StoredGameInfo.self).filter(predicate)
        
        guard let first = results.first else {
            return nil
        }
        return GameInfo(from: first)
    }
}

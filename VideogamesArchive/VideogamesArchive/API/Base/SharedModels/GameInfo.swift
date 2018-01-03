//
//  GameInfo.swift
//  VideogamesArchive
//
//  Created by Rigoberto Saenz on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

struct GameInfo: Codable {
    let id: Int
    let name: String
    let url: String
    let summary: String?
    let storyline: String?
    let rating: Float?
    let screenshots: [Logo]?
    let cover: Logo?
    
//    init(from item: StoredGameInfo) {
//        self.id = item.id
//        self.name = item.name
//        self.url = item.url
//        self.summary = item.summary
//        self.storyline = item.storyline
//        self.rating = item.rating
//        
//        if let itemImages = item.screenshots {
//            self.screenshots = []
//            
//            for image in itemImages {
//                self.screenshots?.append(Logo(url: image))
//            }
//            
//        } else {
//            self.screenshots = nil
//        }
//        
//        if let itemCover = item.cover {
//            self.cover = Logo(url: itemCover)
//        } else {
//            self.cover = nil
//        }
//    }
}

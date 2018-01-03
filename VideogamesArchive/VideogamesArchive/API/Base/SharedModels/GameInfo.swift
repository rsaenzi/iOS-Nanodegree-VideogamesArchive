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
}

//
//  GamePlatform.swift
//  VideogamesArchive
//
//  Created by Rigoberto Sáenz Imbacuán on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

struct GamePlatform: Codable {
    let id: Int
    let name: String
    let logo: Logo?
    let url: String
    let website: String?
    let summary: String?
    let alternativeName: String?
    let gamesIds: [Int]
    
    // MARK: Decoding & Encoding to JSON
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logo
        case url
        case website
        case summary
        case alternativeName = "alternative_name"
        case gamesIds = "games"
    }
}

//
//  GameCompany.swift
//  VideogamesArchive
//
//  Created by Rigoberto Saenz on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

struct GameCompany: Codable {
    let id: Int
    let name: String
    let url: String
    let developedGamesIds: [Int]?
    let publishedGamesIds: [Int]?
    
    // MARK: Decoding & Encoding to JSON
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case developedGamesIds = "developed"
        case publishedGamesIds = "published"
    }
}

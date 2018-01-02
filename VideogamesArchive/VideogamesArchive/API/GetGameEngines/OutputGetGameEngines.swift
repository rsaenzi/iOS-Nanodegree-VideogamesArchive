//
//  OutputGetGameEngines.swift
//  VideogamesArchive
//
//  Created by Rigoberto Sáenz Imbacuán on 1/1/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

struct OutputGetGameEngines: Codable {
    let id: Int
    let name: String
    let logo: Logo?
    let slug: String
    let url: String
    let gamesIds: [Int]
    let platformsIds: [Int]?
    let companiesIds: [Int]?
    
    // MARK: Decoding & Encoding to JSON
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logo
        case slug
        case url
        case gamesIds = "games"
        case platformsIds = "platforms"
        case companiesIds = "companies"
    }
}

struct Logo: Codable {
    let url: String
}

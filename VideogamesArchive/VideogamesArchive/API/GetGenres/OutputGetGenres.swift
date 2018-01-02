//
//  OutputGetGenres.swift
//  VideogamesArchive
//
//  Created by Rigoberto Saenz on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

struct OutputGetGenres: Codable {
    let id: Int
    let name: String
    let slug: String
    let url: String
    let gamesIds: [Int]
    
    // MARK: Decoding & Encoding to JSON
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case url
        case gamesIds = "games"
    }
}

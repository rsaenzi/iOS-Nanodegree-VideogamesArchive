//
//  ApiEndpoint.swift
//  VideogamesArchive
//
//  Created by Rigoberto Sáenz Imbacuán on 1/1/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

enum ApiEndpoint {
    case getGameEngines
    case getPlatforms
    case getCompanies
    case getGenres
    case getGameInfo(gameId: Int)
}

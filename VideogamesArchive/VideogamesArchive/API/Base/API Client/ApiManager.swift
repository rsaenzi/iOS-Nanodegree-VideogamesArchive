//
//  ApiManager.swift
//  VideogamesArchive
//
//  Created by Rigoberto Sáenz Imbacuán on 1/1/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import Moya

private let igdbUserKey = "e78a9b26f1f705111bb01793a05bdae9"

extension ApiEndpoint: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api-2445582011268.apicast.io")!
    }
    
    var path: String {
        switch self {
            
        case .getGameEngines:
            return "/game_engines/"
            
        case .getPlatforms:
            return "/platforms/"
            
        case .getCompanies:
            return "/companies/"
            
        case .getGenres:
            return "/genres/"
        }
    }
    
    var method: Method {
        switch self {
            
        case .getGameEngines, .getPlatforms, .getCompanies, .getGenres:
            return .get
        }
    }
    
    var headers: [String: String]? {
        var headers = [String: String]()
        headers["Accept"] = "application/json"
        headers["user-key"] = igdbUserKey
        return headers
    }
    
    var task: Task {
        switch self {
            
        case .getGameEngines, .getPlatforms, .getCompanies, .getGenres:
            let urlParameters: [String: Any] = ["fields": "*"]
            return .requestParameters(parameters: urlParameters, encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        return "".utf8Encoded
    }
}

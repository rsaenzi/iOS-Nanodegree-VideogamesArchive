//
//  ResponseGetPlatforms.swift
//  VideogamesArchive
//
//  Created by Rigoberto Sáenz Imbacuán on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import Moya

enum ResponseGetPlatforms {
    
    // Specific Responses
    case success(output: [GamePlatform])
    
    // Status Code Errors
    case invalidStatusCode(statusCode: Int)
    case httpRedirectionError(statusCode: Int)
    case httpClientError(statusCode: Int)
    case httpServerError(statusCode: Int)
    
    // Request Errors
    case resultDataError(response: Moya.Response)
    case jsonDecodingError(jsonString: String)
    case requestFailure(reason: String)
    case noInternet
}

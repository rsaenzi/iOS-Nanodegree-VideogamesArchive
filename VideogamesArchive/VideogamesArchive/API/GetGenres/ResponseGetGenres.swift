//
//  ResponseGetGenres.swift
//  VideogamesArchive
//
//  Created by Rigoberto Saenz on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import Moya

enum ResponseGetGenres {
    
    // Specific Responses
    case success(output: [OutputGetGenres])
    
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

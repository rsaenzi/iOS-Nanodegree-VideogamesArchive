//
//  RequestGetGenres.swift
//  VideogamesArchive
//
//  Created by Rigoberto Saenz on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import Foundation
import Moya

typealias CompletionGetGenres = (_ response: ResponseGetGenres) -> Void

class RequestGetGenres {
    
    private init() {}
    
    static func request(completion callback: @escaping CompletionGetGenres) {
        
        let endpoint = ApiEndpoint.getGenres
        
        RequestApi.request(to: endpoint) { response in
            switch response {
                
            case .success(let result):
                handleResponse(result, callback)
                
            case .failure(let error):
                call(callback, .requestFailure(reason: error))
                
            case .offline, .timeOut:
                call(callback, .noInternet)
            }
        }
    }
    
    private static func handleResponse(_ resultData: Response, _ callback: @escaping CompletionGetGenres) {
        
        let code = resultData.statusCode
        
        // Convert raw data into a json string
        guard let jsonString = ApiUtils.getJsonString(from: resultData) else {
            call(callback, .resultDataError(response: resultData))
            return
        }
        
        // HTTP status code validation
        switch code {
        case 200:
            handleSuccess(jsonString, callback)
            
        case 300...399:
            call(callback, .httpRedirectionError(statusCode: code))
            
        case 400...499:
            call(callback, .httpClientError(statusCode: code))
            
        case 500...599:
            call(callback, .httpServerError(statusCode: code))
            
        default:
            call(callback, .invalidStatusCode(statusCode: code))
        }
    }
    
    private static func handleSuccess(_ jsonString: String, _ callback: @escaping CompletionGetGenres) {
        
        // Converts the jsonString into a valid Object
        guard let output: [OutputGetGenres] = jsonString.decodeFrom() else {
            call(callback, .jsonDecodingError(jsonString: jsonString))
            return
        }
        
        // Returns the parsed object
        call(callback, .success(output: output))
    }
    
    private static func call(_ callback: @escaping CompletionGetGenres, _ result: ResponseGetGenres) {
        DispatchQueue.main.async {
            callback(result)
        }
    }
}





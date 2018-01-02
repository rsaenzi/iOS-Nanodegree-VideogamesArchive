//
//  RequestApi.swift
//  VideogamesArchive
//
//  Created by Rigoberto Sáenz Imbacuán on 1/1/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import Foundation
import Moya
import Result

typealias CompletionApiRequest = (_ response: ResponseApi) -> Void

class RequestApi {
    
    private init() {}
    
    static func request(to endpoint: ApiEndpoint, authenticate: Bool = false,
                        completion callback: @escaping CompletionApiRequest) {
        
        // Here we perform the request
        let provider = MoyaProvider<ApiEndpoint>()
        provider.request(endpoint) { result in
            
            // Only for debugging
            ApiUtils.printResponse(result, endpoint: endpoint)
            
            // Here only handle errors
            switch result {
                
            case .success(let data):
                callback(.success(result: data))
                
            case .failure(let requestError):
                
                // Let's determine if the failure was caused by a internet connectivity problem
                switch requestError {
                case .underlying(let swiftError as NSError, _):
                    
                    switch swiftError.code {
                        
                    case -1001: // Reason: The request timed out
                        callback(.timeOut(error: requestError.localizedDescription))
                        return
                        
                    case -1009: // Reason: The Internet connection appears to be offline
                        callback(.offline(error: requestError.localizedDescription))
                        return
                        
                    default:
                        break
                    }
                    
                default:
                    break
                }
                
                // The error was caused by a different reason
                callback(.failure(error: requestError.localizedDescription))
            }
        }
    }
}

// MARK: Plugin for Logging
struct PrintRequest: PluginType {
    
    /// Called immediately before a request is sent over the network (or stubbed).
    func willSend(_ request: RequestType, target: TargetType) {
        ApiUtils.print(request: request.request!)
    }
}

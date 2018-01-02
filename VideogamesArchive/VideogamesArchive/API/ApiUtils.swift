//
//  ApiUtils.swift
//  VideogamesArchive
//
//  Created by Rigoberto Sáenz Imbacuán on 1/1/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import Foundation
import Moya
import Result

class ApiUtils {
    
    static func getJsonString(from response: Moya.Response) -> String? {
        
        let jsonString: String
        
        do {
            jsonString = try response.mapString()
            
        } catch {
            Swift.print(error)
            return nil
        }
        
        return jsonString
    }
    
    static func print(request: URLRequest) {
        
        var url = "None"
        if let methodString = request.httpMethod,
            let requestUrl = request.url {
            url = "\(methodString) \(requestUrl)"
        }
        
        var headers = "None"
        if let headerContent = request.allHTTPHeaderFields {
            headers = headerContent.debugDescription
        }
        
        var body = "None"
        if let dataString = request.httpBody,
            let jsonString = String(data: dataString, encoding: .utf8) {
            body = "\n" + jsonString
        }
        
        let info = """
        Request to \(url)
        Headers: \(headers)
        Body: \(body)
        """
        
        Swift.print(info)
    }
    
    static func printResponse(_ result: Result<Moya.Response, MoyaError>, endpoint: TargetType) {
        
        var url = "None"
        var body = "None"
        var statusCode = 0
        
        switch result {
            
        case .success(let resultData):
            
            if let methodString = resultData.request?.httpMethod,
                let requestUrl = resultData.request?.url {
                url = "\(methodString) \(requestUrl)"
            }
            
            if let jsonString = ApiUtils.getJsonString(from: resultData) {
                body = "\n" + jsonString
            }
            
            statusCode = resultData.statusCode
            
        case .failure(let requestError):
            
            url = "\(endpoint.method.rawValue.uppercased()) \(endpoint.baseURL)\(endpoint.path)"
            
            if let response = requestError.response,
                let jsonString = ApiUtils.getJsonString(from: response) {
                body = "\n" + jsonString
            }
            
            statusCode = requestError.response?.statusCode ?? 0
            
            // Test Internet connection
            switch requestError {
            case .underlying(let swiftError as NSError, _):
                
                statusCode = swiftError.code
                body = swiftError.localizedDescription
                
            default:
                break
            }
        }
        
        let info = """
        Response from \(url)
        Status Code: \(statusCode)
        Body: \(body)
        """
        
        Swift.print(info)
    }
    
    static func printNoInternet(using endpoint: TargetType) {
        
        let url = "\(endpoint.method.rawValue.uppercased()) \(endpoint.baseURL)\(endpoint.path)"
        
        let info = """
        Request to: \(url)
        No Internet Connection
        """
        
        Swift.print(info)
    }
}

extension Encodable {
    
    func encodeToJson() -> String? {
        
        let encoder = JSONEncoder()
//        encoder.dateEncodingStrategy = .formatted(DateFormats.server.formatter)
        encoder.outputFormatting = .prettyPrinted
        
        let jsonData: Data
        
        do {
            jsonData = try encoder.encode(self)
            
        } catch {
            print(error)
            return nil
        }
        
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            return nil
        }
        
        guard jsonString.count > 0 else {
            return nil
        }
        
        return jsonString
    }
}

extension String {
    
    func decodeFrom<T: Decodable>() -> T? {
        
        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .formatted(DateFormats.server.formatter)
        
        guard let jsonData = self.data(using: .utf8) else {
            return nil
        }
        
        let object: T
        do {
            object = try decoder.decode(T.self, from: jsonData)
        } catch {
            print(error)
            return nil
        }
        
        return object
    }
    
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}


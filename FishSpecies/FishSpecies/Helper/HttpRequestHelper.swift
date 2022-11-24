//
//  HttpRequestHelper.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import Foundation

enum HTTPHeaderFields {
    case applicationJson
    case applicationXWWWFormUrlencoded
    case none
}
enum NetworkError: Error, LocalizedError {
    case noInternet
    case httpStatus(Int)
    case unknown(Error)
    case genericError
    case noError
    
    public var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No Internet"
            
        case .httpStatus(let code):
            return "HTTP status code: \(code)"
            
        case .unknown(let error):
            return "Error: \(error)"
            
        case .genericError:
            return "Generic Error"
            
        case .noError:
            return nil
            
        }
    }
}

typealias Completion = (Bool, Data?, NetworkError?) -> Void

class HttpRequestHelper {
    func GET(url: String, params: [String: String], httpHeader: HTTPHeaderFields, complete: @escaping Completion) {
        guard var components = URLComponents(string: url) else {
            return
        }
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = components.url else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        switch httpHeader {
        case .applicationJson:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .applicationXWWWFormUrlencoded:
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        case .none: break
        }
        
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                complete(false, nil, NetworkError.unknown(error!))
                return
            }
            guard let data = data else {
                complete(false, nil, NetworkError.genericError)
                return
            }
            if let urlresponse = response as? HTTPURLResponse, (200 ..< 300) ~= urlresponse.statusCode {
                if urlresponse.statusCode == 200 {
                    complete(true, data, NetworkError.noError)
                } else {
                    complete(false, nil, NetworkError.httpStatus(urlresponse.statusCode))
                }
                return
            }
            complete(true, data, NetworkError.noError)
        }.resume()
    }
}

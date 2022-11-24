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
    private enum Constants {
        static let contentType = "Content-Type"
        static let applicationJson = "application/json"
        static let applicationXWWWFormUrlencoded = "application/x-www-form-urlencoded"
    }
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
            request.setValue(Constants.applicationJson, forHTTPHeaderField: Constants.contentType)
        case .applicationXWWWFormUrlencoded:
            request.setValue(Constants.applicationXWWWFormUrlencoded, forHTTPHeaderField: Constants.contentType)
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
            if let urlresponse = response as? HTTPURLResponse {
                if (200 ..< 300) ~= urlresponse.statusCode   {
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

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

class HttpRequestHelper {
    func GET(url: String, params: [String: String], httpHeader: HTTPHeaderFields, complete: @escaping (Bool, Data?) -> Void) {
        guard var components = URLComponents(string: url) else {
            print("Error: cannot create URLCompontents")
            return
        }
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }

        guard let url = components.url else {
            print("Error: cannot create URL")
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
                print("Error: problem calling GET")
                print(error!)
                complete(false, nil)
                return
            }
            guard let data = data else {
                print("Error: did not receive data")
                complete(false, nil)
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                complete(false, nil)
                return
            }
            complete(true, data)
        }.resume()
    }
}

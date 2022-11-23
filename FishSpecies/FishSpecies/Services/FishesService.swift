//
//  FishesService.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import Foundation

protocol FishSpeciesServiceProtocol {
    func getFishSpecies(completion: @escaping (_ success: Bool, _ results: Fish?, _ error: String?) -> ())
}

class FishService: FishSpeciesServiceProtocol {
    func getFishSpecies(completion: @escaping (Bool, Fish?, String?) -> ()) {
        HttpRequestHelper().GET(url: AppConstants.Fishwatch_EndPoint_URLString, params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Fish.self, from: data!)
                    completion(true, model, nil)
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }/*catch {
                    completion(false, nil, "Error: Trying to parse Fishes to model")
                }*/
            } else {
                completion(false, nil, "Error: Fishes GET Request failed")
            }
        }
    }
}

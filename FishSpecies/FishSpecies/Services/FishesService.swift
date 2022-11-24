//
//  FishesService.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import Foundation

protocol FishSpeciesServiceProtocol {
    func getFishSpecies(completion: @escaping (_ success: Bool, _ results: Fish?, _ error: String?) -> Void)
}

class FishService: FishSpeciesServiceProtocol {
    func getFishSpecies(completion: @escaping (Bool, Fish?, String?) -> Void) {
        HttpRequestHelper().GET(url: AppConstants.FishwatchEndPointURLString, params: ["": ""], httpHeader: .applicationJson) { success, data, err  in
            if success {
                do {
                    let model = try JSONDecoder().decode(Fish.self, from: data!)
                    completion(true, model, err?.errorDescription)
                } catch {
                    completion(false, nil, "Error: \(err?.errorDescription ?? AppConstants.kEmptyStr)")
                }
            } else {
                completion(false, nil, "Error: \(err?.errorDescription ?? AppConstants.kEmptyStr)")
            }
        }
    }
}

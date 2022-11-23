//
//  MockServiceTests.swift
//  FishSpeciesTests
//
//  Created by MacBook Pro on 23/11/22.
//

import XCTest
@testable import FishSpecies

class MockService: FishSpeciesServiceProtocol {
    
    func getFishSpecies(completion: @escaping (Bool, Fish?, String?) -> ()) {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "UnitTestData", ofType: "json") else {
            fatalError("UnitTestData.json not found")
        }
        
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert UnitTestData.json to String")
        }
                
        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert UnitTestData.json to Data")
        }
        
        
        do {
            let model = try JSONDecoder().decode(Fish.self, from: jsonData)
            completion(true, model, nil)
        }
        catch {
            completion(false, nil, "Error: Trying to parse Fishes to model")
        }
    }
}

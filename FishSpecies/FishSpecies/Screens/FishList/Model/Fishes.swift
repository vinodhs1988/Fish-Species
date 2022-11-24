//
//  Fishes.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import Foundation

typealias Fish = [FishElement]

protocol FishDetailElementProtocol {
    var speciesIllustrationPhoto: SpeciesIllustrationPhoto? { get }
    var scientificName: String? { get }
    var speciesName: String? { get }
    var harvest: String? { get }
    var population: String? { get }
    var populationStatus: String? { get }
    var physicalDescription: String? { get }
    
}

struct FishDetailElement: FishDetailElementProtocol {
    var speciesIllustrationPhoto: SpeciesIllustrationPhoto?
    var scientificName: String?
    var speciesName: String?
    var harvest: String?
    var population: String?
    var populationStatus: String?
    var physicalDescription: String?
}

// MARK: - FishElement
struct FishElement: Decodable {
    
    let fisheryManagement: String?
    let habitat: String?
    let habitatImpacts: String?
    let imageGallery: ImageGallery?
    let location: String?
    let management: String?
    let noaaFisheriesRegion: String?
    let population: String?
    let populationStatus: String?
    let scientificName: String?
    let speciesAliases: String
    let speciesIllustrationPhoto: SpeciesIllustrationPhoto?
    let speciesName: String
    let animalHealth: String?
    let availability: String
    let biology: String
    let bycatch: String?
    let calories: String?
    let carbohydrate: String?
    let cholesterol: String?
    let color: String?
    let diseaseTreatmentAndPrevention: String?
    let diseasesInSalmon: String?
    let displayedSeafoodProfileIllustration: String?
    let ecosystemServices: String?
    let environmentalConsiderations: String?
    let environmentalEffects: String?
    let farmingMethods: String?
    let fishFarmingMethods: String?
    let fatTotal: String?
    let fishFeeds: String?
    let feeds: String?
    let fiberTotalDietary: String?
    let fishingRate: String?
    let harvest: String?
    let harvestType: String?
    let healthBenefits: String?
    let fishHumanHealth: String?
    let humanHealth: String?
    let physicalDescription: String
    let production, protein: String?
    let quote, quoteBackgroundColor: String
    let research: String?
    let saturatedFattyAcidsTotal: String?
    let selenium: String?
    let servingWeight: String?
    let servings, sodium: String?
    let source: String
    let sugarsTotal: String?
    let taste: String?
    let texture: String?
    let path, lastUpdate: String
    
    enum CodingKeys: String, CodingKey {
        case fisheryManagement = "Fishery Management"
        case habitat = "Habitat"
        case habitatImpacts = "Habitat Impacts"
        case imageGallery = "Image Gallery"
        case location = "Location"
        case management = "Management"
        case noaaFisheriesRegion = "NOAA Fisheries Region"
        case population = "Population"
        case populationStatus = "Population Status"
        case scientificName = "Scientific Name"
        case speciesAliases = "Species Aliases"
        case speciesIllustrationPhoto = "Species Illustration Photo"
        case speciesName = "Species Name"
        case animalHealth = "Animal Health"
        case availability = "Availability"
        case biology = "Biology"
        case bycatch = "Bycatch"
        case calories = "Calories"
        case carbohydrate = "Carbohydrate"
        case cholesterol = "Cholesterol"
        case color = "Color"
        case diseaseTreatmentAndPrevention = "Disease Treatment and Prevention"
        case diseasesInSalmon = "Diseases in Salmon"
        case displayedSeafoodProfileIllustration = "Displayed Seafood Profile Illustration"
        case ecosystemServices = "Ecosystem Services"
        case environmentalConsiderations = "Environmental Considerations"
        case environmentalEffects = "Environmental Effects"
        case farmingMethods = "Farming Methods"
        case fishFarmingMethods = "Farming Methods_"
        case fatTotal = "Fat, Total"
        case fishFeeds = "Feeds_"
        case feeds = "Feeds"
        case fiberTotalDietary = "Fiber, Total Dietary"
        case fishingRate = "Fishing Rate"
        case harvest = "Harvest"
        case harvestType = "Harvest Type"
        case healthBenefits = "Health Benefits"
        case fishHumanHealth = "Human_Health_"
        case humanHealth = "Human Health"
        case physicalDescription = "Physical Description"
        case production = "Production"
        case protein = "Protein"
        case quote = "Quote"
        case quoteBackgroundColor = "Quote Background Color"
        case research = "Research"
        case saturatedFattyAcidsTotal = "Saturated Fatty Acids, Total"
        case selenium = "Selenium"
        case servingWeight = "Serving Weight"
        case servings = "Servings"
        case sodium = "Sodium"
        case source = "Source"
        case sugarsTotal = "Sugars, Total"
        case taste = "Taste"
        case texture = "Texture"
        case path = "Path"
        case lastUpdate = "last_update"
    }
}

// MARK: - ImageGallery

enum ImageGallery {
    case single(SpeciesIllustrationPhoto)
    case array([SpeciesIllustrationPhoto])
}

extension ImageGallery: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let singleFilm = try? container.decode(SpeciesIllustrationPhoto.self) {
            self = .single(singleFilm)
        } else {
            try self = .array(container.decode([SpeciesIllustrationPhoto].self))
        }
    }
}

extension ImageGallery {
    var values: [SpeciesIllustrationPhoto] {
        switch self {
        case .single(let film): return [film]
        case .array(let films): return films
        }
    }
}

// MARK: - SpeciesIllustrationPhoto
struct SpeciesIllustrationPhoto: Decodable {
    let src: String?
    let alt, title: String?
}

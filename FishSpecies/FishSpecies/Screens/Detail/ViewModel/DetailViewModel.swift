//
//  DetailViewModel.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import Foundation

class DetailViewModel: NSObject{
    
    var updateDataSource: (() -> Void)?
    
    var fishSpeciesDetail: FishElement?{
        didSet{
            self.createDetailPageModel()
        }
    }
    
    var detailPageViewModel: DetailPageViewModel?{
        didSet{
            updateDataSource?()
        }
    }
    
    
    override init() { }
    
    func createDetailPageModel() {
        let imageUrlStr = fishSpeciesDetail?.speciesIllustrationPhoto?.src ?? ""
        let pageDescriptionArr : [String] = [(fishSpeciesDetail?.speciesName ?? "") , (fishSpeciesDetail?.scientificName ?? "") ,(fishSpeciesDetail?.physicalDescription ?? "") , (fishSpeciesDetail?.harvest ?? "") , (fishSpeciesDetail?.population ?? "") , (fishSpeciesDetail?.populationStatus ?? "")]
        let pageDescription = pageDescriptionArr.joined(separator: "\n\n")
        self.detailPageViewModel = DetailPageViewModel(imageUrlStr: imageUrlStr, pageDescription: pageDescription)
    }
}


struct DetailPageViewModel {
    var imageUrlStr: String = ""
    var pageDescription: String = ""
}

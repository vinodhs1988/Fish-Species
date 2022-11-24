//
//  FishDetailViewModel.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import Foundation

class FishDetailViewModel: NSObject {
    
    var updateDataSource: (() -> Void)?
    
    var fishSpeciesDetail: FishElement? {
        didSet {
            createDetailPageModel()
        }
    }
    
    var detailPageViewModel: DetailPageViewModel? {
        didSet {
            updateDataSource?()
        }
    }
    
    override init() { }
    
    func createDetailPageModel() {
        let imageUrlStr = fishSpeciesDetail?.speciesIllustrationPhoto?.src ?? AppConstants.kEmptyStr
        let pageDescriptionArr: [String] = [(fishSpeciesDetail?.speciesName ?? AppConstants.kEmptyStr),
                                            (fishSpeciesDetail?.scientificName ?? AppConstants.kEmptyStr),
                                            (fishSpeciesDetail?.physicalDescription ?? AppConstants.kEmptyStr),
                                            (fishSpeciesDetail?.harvest ?? AppConstants.kEmptyStr),
                                            (fishSpeciesDetail?.population ?? AppConstants.kEmptyStr),
                                            (fishSpeciesDetail?.populationStatus ?? AppConstants.kEmptyStr)]
        let pageDescription = pageDescriptionArr.joined(separator: AppConstants.doubleHTMLBreak)
        self.detailPageViewModel = DetailPageViewModel(imageUrlStr: imageUrlStr, pageDescription: pageDescription)
    }
}

struct DetailPageViewModel {
    var imageUrlStr: String = ""
    var pageDescription: String = ""
}

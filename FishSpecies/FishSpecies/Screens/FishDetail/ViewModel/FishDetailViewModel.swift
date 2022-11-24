//
//  FishDetailViewModel.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import Foundation

class FishDetailViewModel: NSObject {
    
    var updateDataSource: (() -> Void)?
    
    var fishSpeciesDetail: FishDetailElementProtocol?
    
    var detailPageViewModel: DetailPageViewModel? {
        didSet {
            updateDataSource?()
        }
    }
    
    init(detailElement: FishDetailElementProtocol = FishDetailElement()) {
        super.init()
        self.fishSpeciesDetail = detailElement
        self.createDetailPageModel()
    }
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

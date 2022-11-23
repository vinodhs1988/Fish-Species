//
//  FishListViewModel.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import Foundation

class FishListViewModel: NSObject {
    
    private var fishSpeciesService: FishSpeciesServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    private var fishSpecies = Fish()
    
    private var homeCellViewModels = [FishListCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(fishSpeciesService: FishSpeciesServiceProtocol = FishService()) {
        self.fishSpeciesService = fishSpeciesService
    }
    
    func getfishSpeciesDetails() {
        fishSpeciesService.getFishSpecies { success, results, error in
            if success, let fishSpecies = results {
                self.fetchData(fishSpecies: fishSpecies)
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(fishSpecies: Fish) {
        self.fishSpecies = fishSpecies
        var vms = [FishListCellViewModel]()
        for fishSpecie in fishSpecies {
            vms.append(createHomeModel(homeModel: fishSpecie))
        }
        homeCellViewModels = vms
    }
    
    func createHomeModel(homeModel: FishElement) -> FishListCellViewModel {
        let name = homeModel.speciesName
        let scientificName = homeModel.scientificName
        let imageUrlStr = homeModel.speciesIllustrationPhoto?.src ?? ""
        
        return FishListCellViewModel(name: name, scientificName: scientificName, imageUrlStr: imageUrlStr)
    }
    
    func getNumberofRows() -> Int {
        return homeCellViewModels.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> FishListCellViewModel {
        return homeCellViewModels[indexPath.row]
    }
    
    func getFishSpecies(at indexPath: IndexPath) -> FishElement {
        return fishSpecies[indexPath.row]
    }
}

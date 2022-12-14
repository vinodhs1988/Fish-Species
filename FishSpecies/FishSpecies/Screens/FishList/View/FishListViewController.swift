//
//  FishListViewController.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import Foundation
import UIKit

class FishListViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    
    lazy var viewModel = {
        FishListViewModel()
    }()
    
    override func prepareView() {
        setupTableView()
        registerNib()
        showLoader()
        
        fetchSpeciesDetailsAndLoadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  AppConstants.DetailPageSegueIdentifier {
            let destVC = segue.destination as? FishDetailViewController
            let fishSpeciesDetail = viewModel.getFishSpecies(at: self.tableView.indexPathForSelectedRow ?? IndexPath(row: 0, section: 0))
            let detailElement = FishDetailElement(speciesIllustrationPhoto: fishSpeciesDetail.speciesIllustrationPhoto,
                                                  scientificName: fishSpeciesDetail.scientificName,
                                                  speciesName: fishSpeciesDetail.speciesName,
                                                  harvest: fishSpeciesDetail.harvest,
                                                  population: fishSpeciesDetail.population,
                                                  populationStatus: fishSpeciesDetail.populationStatus,
                                                  physicalDescription: fishSpeciesDetail.physicalDescription)
            destVC?.viewModel = FishDetailViewModel(detailElement: detailElement)
        }
    }
}

extension FishListViewController {
    
    private func showLoader() {
        Loader.showProgressView(title: AppConstants.downloadingStr, context: self.view)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .darkGray
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        
        navigationController?.hidesBarsOnSwipe = false
    }
    
    private func registerNib() {
        tableView.register(FishListCell.nib, forCellReuseIdentifier: FishListCell.identifier)
    }
    
    private func fetchSpeciesDetailsAndLoadData() {
        viewModel.getfishSpeciesDetails()
        
        viewModel.reloadTableView = { [unowned self] in
            DispatchQueue.main.async {
                Loader.hideProgressView()
                self.tableView.reloadData()
            }
        }
    }
}
extension FishListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: AppConstants.DetailPageSegueIdentifier, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension FishListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FishListCell.identifier, for: indexPath) as? FishListCell else {
            return UITableViewCell()
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}

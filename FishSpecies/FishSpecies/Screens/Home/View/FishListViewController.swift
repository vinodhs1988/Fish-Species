//
//  FishListViewController.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import Foundation
import UIKit

class FishListViewController: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    
    lazy var viewModel = {
        FishListViewModel()
    }()
    
    private var activityIndicatorView: ActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        initViewModel()
    }
    
    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .darkGray
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        
        tableView.register(FishListCell.nib, forCellReuseIdentifier: FishListCell.identifier)
        
        navigationController?.hidesBarsOnSwipe = false
        
        self.activityIndicatorView = ActivityIndicatorView(title: "Downloading Data...", center: self.view.center)
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        self.activityIndicatorView.startAnimating()
    }
    
    private func initViewModel() {
        viewModel.getfishSpeciesDetails()
        
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicatorView.stopAnimating()
                self?.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  AppConstants.DetailPageSegueIdentifier{
            let destVC = segue.destination as? FishDetailViewController
            let fishSpeciesDetail = viewModel.getFishSpecies(at: self.tableView.indexPathForSelectedRow ?? IndexPath(row: 0, section: 0))
            destVC?.viewModel.fishSpeciesDetail = fishSpeciesDetail
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
        return viewModel.getNumberofRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FishListCell.identifier, for: indexPath) as? FishListCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}

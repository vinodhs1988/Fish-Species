//
//  HomeViewController.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    
    lazy var viewModel = {
        HomeViewModel()
    }()
    
    var activityIndicatorView: ActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        let jailbrokenLabelText = "Is JailBroken - \(UIDevice.current.isJailBroken)"
        print(jailbrokenLabelText)
        if UIDevice.current.isJailBroken {
            let alert = UIAlertController(title: "System Requirements", message: "Sorry, your iOS seems to be modified. This app is only supported on unmodified versions of iOS.", preferredStyle: UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
        } else{
            initViewModel()
        }

    }
    
    func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .darkGray
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        
        tableView.register(HomeCell.nib, forCellReuseIdentifier: HomeCell.identifier)
        
        navigationController?.hidesBarsOnSwipe = false
        
        self.activityIndicatorView = ActivityIndicatorView(title: "Downloading Data...", center: self.view.center)
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        self.activityIndicatorView.startAnimating()
    }
    
    func initViewModel() {
        viewModel.getfishSpeciesDetails()
        
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicatorView.stopAnimating()
                self?.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "moveToDetailPage"{
            let destVC = segue.destination as? DetailViewController
            let fishSpeciesDetail = viewModel.getFishSpecies(at: self.tableView.indexPathForSelectedRow ?? IndexPath(row: 0, section: 0))
            destVC?.viewModel.fishSpeciesDetail = fishSpeciesDetail
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "moveToDetailPage", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberofRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}

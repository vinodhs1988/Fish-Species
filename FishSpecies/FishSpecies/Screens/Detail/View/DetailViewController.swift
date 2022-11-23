//
//  DetailViewController.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import Foundation
import UIKit
import SDWebImage


class DetailViewController: UIViewController{

    lazy var viewModel = {
        DetailViewModel()
    }()

    @IBOutlet var fishDetailTextView: UITextView!
    @IBOutlet var fishImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        self.navigationItem.title = self.viewModel.fishSpeciesDetail?.speciesName
        self.fishImageView.contentMode = .scaleAspectFill

        if let imageUrlStr = self.viewModel.detailPageViewModel?.imageUrlStr, !imageUrlStr.isEmpty{
            self.fishImageView.sd_setImage(with: URL(string: imageUrlStr), placeholderImage:AppConstants.placeholderImg)
        } else {
            self.fishImageView.image = AppConstants.placeholderImg
        }
        self.fishDetailTextView.text = self.viewModel.detailPageViewModel?.pageDescription
    }
}

//
//  DetailViewController.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import Foundation
import UIKit


class DetailViewController: UIViewController{

    lazy var viewModel = {
        DetailViewModel()
    }()

    @IBOutlet private var fishDetailTextView: UITextView!
    @IBOutlet private var fishImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        self.navigationItem.title = self.viewModel.fishSpeciesDetail?.speciesName

        fishImageView.layer.cornerRadius = 20.0
        fishImageView.backgroundColor = UIColor.white

        if let imageUrlStr = self.viewModel.detailPageViewModel?.imageUrlStr, !imageUrlStr.isEmpty{
            ImageDownloader.shared.downloadImage(with: imageUrlStr, completionHandler: { downloadedimage, isDownloaded in
                self.fishImageView.image = downloadedimage
            }, placeholderImage: AppConstants.placeholderImg)

        } else {
            self.fishImageView.image = AppConstants.placeholderImg
        }
        self.fishDetailTextView.text = self.viewModel.detailPageViewModel?.pageDescription
    }
}

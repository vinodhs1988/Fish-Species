//
//  FishDetailViewController.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import Foundation
import UIKit
import SDWebImage

class FishDetailViewController: BaseViewController {
    
    private enum Constants {
        static let imageCornerRadius: CGFloat = 20.0
        static let whiteColor = UIColor.white
    }
    
    var viewModel: FishDetailViewModel?
    
    @IBOutlet private var fishDetailTextView: UITextView!
    @IBOutlet private var fishImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavigationBar()
        setupImageView()
        
        loadPageData()
    }
    
    private func loadPageData() {
        if let imageUrlStr = self.viewModel?.detailPageViewModel?.imageUrlStr, !imageUrlStr.isEmpty {
            self.fishImageView.sd_setImage(with: URL(string: imageUrlStr))
        }
        self.fishDetailTextView.attributedText = self.viewModel?.detailPageViewModel?.pageDescription.htmlToAttributedString
    }
    
    private func setupImageView() {
        fishImageView.layer.cornerRadius = 20.0
        fishImageView.backgroundColor = UIColor.white
    }
    
    private func prepareNavigationBar() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.title = self.viewModel?.fishSpeciesDetail?.speciesName
    }
    
}

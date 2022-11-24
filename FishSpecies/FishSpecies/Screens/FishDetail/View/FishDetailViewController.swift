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
    
    override func prepareView() {
        prepareNavigationBar()
        setupImageView()
        
        loadPageData()
    }
    
    private func loadPageData() {
        guard let imageUrlStr = self.viewModel?.detailPageViewModel?.imageUrlStr else { return }
        if !imageUrlStr.isEmpty {
            self.fishImageView.loadImageUsingCache(withUrl: imageUrlStr)
        }
        self.fishDetailTextView.attributedText = self.viewModel?.detailPageViewModel?.pageDescription.htmlToAttributedString
    }
    
    private func setupImageView() {
        fishImageView.layer.cornerRadius = Constants.imageCornerRadius
        fishImageView.backgroundColor = Constants.whiteColor
    }
    
    private func prepareNavigationBar() {
        let backbuttonItem = UIBarButtonItem(title: AppConstants.kEmptyStr, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backbuttonItem
        navigationItem.title = self.viewModel?.fishSpeciesDetail?.speciesName
    }
    
}

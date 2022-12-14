//
//  HomeCell.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import UIKit

class FishListCell: UITableViewCell {
    
    private enum Constants {
        static let imageCornerRadius: CGFloat = 10.0
        static let whiteColor = UIColor.white
    }
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var scientificNameLabel: UILabel!
    @IBOutlet private var fishImageView: UIImageView!
    
    var cellViewModel: FishListCellViewModel? {
        didSet {
            nameLabel.text = cellViewModel?.name
            scientificNameLabel.text = cellViewModel?.scientificName
            if let imageUrlStr = cellViewModel?.imageUrlStr {
                fishImageView.loadImageUsingCache(withUrl: imageUrlStr)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupImageView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    private func setupImageView() {
        fishImageView.layer.cornerRadius = Constants.imageCornerRadius
        fishImageView.backgroundColor = Constants.whiteColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCellValues()
    }
    
    private func resetCellValues() {
        fishImageView.image = UIImage()
        fishImageView.image = nil
        nameLabel.text = nil
        scientificNameLabel.text = nil
    }
}

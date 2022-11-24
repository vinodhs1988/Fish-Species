//
//  HomeCell.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import UIKit
import SDWebImage

class FishListCell: UITableViewCell {
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var scientificNameLabel: UILabel!
    @IBOutlet private var fishImageView: UIImageView!
    
    var cellViewModel: FishListCellViewModel? {
        didSet {
            nameLabel.text = cellViewModel?.name
            scientificNameLabel.text = cellViewModel?.scientificName
            if let imageUrlStr = cellViewModel?.imageUrlStr {
                fishImageView.sd_setImage(with: URL(string: imageUrlStr))
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
        fishImageView.layer.cornerRadius = 10
        fishImageView.backgroundColor = UIColor.white
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

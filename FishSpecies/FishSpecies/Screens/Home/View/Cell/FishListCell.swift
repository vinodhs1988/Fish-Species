//
//  HomeCell.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import UIKit

class FishListCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var scientificNameLabel: UILabel!
    @IBOutlet var fishImageView: UIImageView!

    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    var cellViewModel: FishListCellViewModel? {
        didSet {
            nameLabel.text = cellViewModel?.name
            scientificNameLabel.text = cellViewModel?.scientificName
            if let imageUrlStr = cellViewModel?.imageUrlStr {
                self.fishImageView.loadImageUsingCache(withUrl: imageUrlStr)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    private func initView() {
        backgroundColor = .clear
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        
        fishImageView.layer.cornerRadius = 10
        fishImageView.backgroundColor = UIColor.white

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        fishImageView.image = UIImage()
        fishImageView.image = nil
        nameLabel.text = nil
        scientificNameLabel.text = nil
    }

}

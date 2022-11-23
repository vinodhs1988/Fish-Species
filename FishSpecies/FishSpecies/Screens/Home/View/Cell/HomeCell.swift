//
//  HomeCell.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import UIKit
import SDWebImage

class HomeCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var scientificNameLabel: UILabel!
    @IBOutlet var fishImageView: UIImageView!

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    var cellViewModel: HomeCellViewModel? {
        didSet {
            nameLabel.text = cellViewModel?.name
            scientificNameLabel.text = cellViewModel?.scientificName
            if let imageUrlStr = cellViewModel?.imageUrlStr{
                fishImageView.sd_setImage(with: URL(string: imageUrlStr), placeholderImage:AppConstants.placeholderImg)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initView()
    }

    func initView() {
        backgroundColor = .clear
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        scientificNameLabel.text = nil
    }

}

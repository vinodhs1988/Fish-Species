//
//  HomeCell.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import UIKit

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
                ImageDownloader.shared.downloadImage(with: imageUrlStr, completionHandler: { downloadedimage, isDownloaded in
                        self.fishImageView.image = downloadedimage
                }, placeholderImage: AppConstants.placeholderImg)
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
        
        fishImageView.layer.cornerRadius = fishImageView.bounds.size.height / 2
        fishImageView.layer.shadowColor = UIColor.black.cgColor
        fishImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        fishImageView.layer.shadowOpacity = 1
        fishImageView.backgroundColor = UIColor.white

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        scientificNameLabel.text = nil
    }

}

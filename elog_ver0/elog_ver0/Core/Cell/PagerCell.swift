//
//  PagerCell.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/08/11.
//

import UIKit

class PagerCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleButton: UIButton!

    var titleButtonAction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setImage(url: String) {
        imageView.imageFromServerURL(urlString: url, PlaceHolderImage: nil)
    }

    @IBAction func titleButtonTapped(_ sender: Any) {
        titleButtonAction?()
        
    }
}

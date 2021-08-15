//
//  PagerCell.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/08/11.
//

import UIKit

class PagerCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setImage(url: String) {
        imageView.imageFromServerURL(urlString: url, PlaceHolderImage: nil)
    }

}

extension UIImageView {
    func imageFromServerURL(urlString: String, PlaceHolderImage: UIImage? = nil) {

        if self.image == nil {
            self.image = PlaceHolderImage
        }

        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL) { data, response, error in

            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async { [weak self] in
                let image = UIImage(data: data!)
                self?.image = image
            }

        }.resume()
    }

}

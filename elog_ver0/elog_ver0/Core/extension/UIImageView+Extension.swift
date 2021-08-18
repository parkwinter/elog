//
//  UIImageView+Extension.swift
//  elog_ver0
//
//  Created by 김선우 on 2021/08/18.
//

import UIKit

extension UIImageView {
    func imageFromServerURL(urlString: String, PlaceHolderImage: UIImage? = nil) {

        if self.image == nil {
            self.image = PlaceHolderImage
        }

        let url = NSURL(string: urlString)! as URL

        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async { [weak self] in
                let image = UIImage(data: data!)
                self?.image = image
            }

        }.resume()
    }
}

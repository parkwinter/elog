//
//  UIImageView+Kingfisher.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/08/18.
//

import UIKit
import Kingfisher

extension UIImageView {
    func imageFromServerURL(urlString: String, placeHolderImage: UIImage? = nil) {

        if self.image == nil {
            self.image = placeHolderImage
            return
        }

        //let url = NSURL(string: urlString)! as URL

        let url = URL(string: urlString)
        self.kf.setImage(with: url)
        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if error != nil {
//                print(error!)
//                return
//            }
//
//            DispatchQueue.main.async { [weak self] in
//                let image = UIImage(data: data!)
//                self?.image = image
//            }

        //}.resume()
    }
    
    func imageFromServerURL2(urlString: String, placeHolderImage: UIImage? = nil) {

        if urlString == "" {
            self.image = placeHolderImage
            print("킹피셔에 이미지 비어있어서 nocontentyet으로 채움")
            return
        }
//        if self.image == nil {
//            self.image = PlaceHolderImage
//            return
//        }

        //let url = NSURL(string: urlString)! as URL

        let url = URL(string: urlString)
        
        print("내가 킹피셔로 세팅할 이미지는 \(url!)")
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url!, placeholder: placeHolderImage)
        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if error != nil {
//                print(error!)
//                return
//            }
//
//            DispatchQueue.main.async { [weak self] in
//                let image = UIImage(data: data!)
//                self?.image = image
//            }

        //}.resume()
    }
}

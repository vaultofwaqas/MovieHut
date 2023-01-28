//
//  KFImageManager.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import Kingfisher

struct KFImageManager {
    
    static func setImage(url: String, imageView: UIImageView) {
        if !url.isEmpty {
            if let url = URL(string: url) {
                imageView.kf.indicatorType = .activity
                imageView.kf.setImage(with: url, placeholder: R.image.placeholder())
            } else {
                imageView.image = R.image.placeholder()
            }
        }
    }
}

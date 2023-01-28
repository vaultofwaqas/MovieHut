//
//  MovieRow.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import UIKit

class MovieRow: UITableViewCell {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelMovieDate: UILabel!
    
    public func bind(_ movie: Movie) {
        labelMovieTitle.text = movie.originalTitle
        labelMovieDate.text = movie.releaseDate
        KFImageManager.setImage(url: movie.getPosterUrl(), imageView: imageMovie)
    }
}

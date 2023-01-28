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
        getMovieImage(movie.getPosteUrl())
    }
    
    func getMovieImage(_ withUrl: String) {
        imageMovie.image = R.image.placeholder()
        KFImageManager.setImage(url: withUrl, imageView: imageMovie)
    }
}

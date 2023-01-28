//
//  MovieListRouter.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import Foundation
import UIKit

class MovieListRouter {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        
        let storyboard = getStoryBoard(.movie)
        let view = storyboard.instantiateViewController(ofType: MovieListViewController.self)
        let router = MovieListRouter()
        let viewModel = MovieListViewModelImpl(router: router)
        
        view.viewModel = viewModel
        router.viewController = view

        return view
    }
}

// MARK: - Route Functions
extension MovieListRouter {
    func goToMovieDetail(_ movie: Movie) {
        let navigationController = viewController?.navigationController
        navigationController?.pushViewController(MovieDetailRouter.createModule(movie), animated: true)
    }
}

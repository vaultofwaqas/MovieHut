//
//  LaunchGood
//
//  Copyright © 2022 Bismillah Ar-Rahman Ar-Raheem. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailRouter {
    
    weak var viewController: UIViewController?
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelMovieDate: UILabel!
    @IBOutlet weak var labelMovieDescription: UILabel!
    
    static func createModule(_ movie: Movie) -> UIViewController {
        
        let storyboard = getStoryBoard(.movie)
        let view = storyboard.instantiateViewController(ofType: MovieDetailViewController.self)
        let router = MovieDetailRouter()
        let viewModel = MovieDetailViewModelImpl(router: router)
        
        view.viewModel = viewModel
        router.viewController = view
        
        viewModel.movie = movie

        return view
    }
}

// MARK: - Route Functions
extension MovieDetailRouter {

}

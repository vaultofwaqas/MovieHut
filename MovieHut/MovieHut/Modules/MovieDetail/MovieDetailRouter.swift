//
//  LaunchGood
//
//  Copyright © 2022 Bismillah Ar-Rahman Ar-Raheem. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailRouter {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        
        let storyboard = getStoryBoard(.movie)
        let view = storyboard.instantiateViewController(ofType: MovieDetailViewController.self)
        let router = MovieDetailRouter()
        let viewModel = MovieDetailViewModelImpl(router: router)
        
        view.viewModel = viewModel
        router.viewController = view

        return view
    }
}

// MARK: - Route Functions
extension MovieDetailRouter {

}

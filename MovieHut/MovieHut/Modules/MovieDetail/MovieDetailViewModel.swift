//
//  LaunchGood
//
//  Copyright © 2022 Bismillah Ar-Rahman Ar-Raheem. All rights reserved.
//

import Foundation

typealias MovieDetailViewModelViewSetup = (MovieDetailViewModelImpl.ViewSetup) -> Void

protocol MovieDetailViewModel {
    var viewSetup: MovieDetailViewModelViewSetup? { get set }
    
    // MARK: - Variable Protocols
    var movie: Movie? { get set }
    
    // MARK: - Lifecycle Protocols
    func viewModelDidLoad()
    func viewModelWillAppear()
    func viewModelWillDisappear()
    
    // MARK: - Route Protocols
    
    // MARK: - API Protocols
    
    // MARK: - Logic Protocols
}

class MovieDetailViewModelImpl {

    private let router: MovieDetailRouter
    
    var viewSetup: MovieDetailViewModelViewSetup?
    
    // MARK: - Variables
    var movieManager: MovieManager
    var movie: Movie?
    
    // MARK: - Initializer
    init(router: MovieDetailRouter) {
        self.router = router
        movieManager = MovieManager()
    }
    
    // MARK: - For all of your viewBindings
    enum ViewSetup {
        case setupNavigation
        case setupView
        case showLoader
        case hideLoader
    }
}

// MARK: - Lifecycle Functions
extension MovieDetailViewModelImpl: MovieDetailViewModel {
    func viewModelDidLoad() {
        viewSetup?(.setupNavigation)
        viewSetup?(.setupView)
        movieDetailApi(setMovieDetailPayload())
    }
    
    func viewModelWillAppear() {}
    
    func viewModelWillDisappear() {}
}

// MARK: - Route Functions
extension MovieDetailViewModelImpl {

}

// MARK: - API Functions
extension MovieDetailViewModelImpl {
    
    func setMovieDetailPayload() -> ServicePayload {
        var payload = ServicePayload()
        payload.setPayload(baseUrl: ServiceConstants.movieDetailUrl, apiEndPoint: .movieDetail(movie?.id ?? 0, ServiceConstants.apiKey), requestType: .get)
        return payload
    }
    
    func movieDetailApi(_ withPayload: ServicePayload) {
        movieManager.movieDetailApi(payload: withPayload) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movie): self.populateMovie(movie)
            case .failure: break
            }
        }
    }
}

// MARK: - Logic Functions
extension MovieDetailViewModelImpl {
    private func populateMovie(_ movie: Movie) {
        self.movie = movie
        DispatchQueue.main.async { self.viewSetup?(.setupView) }
    }
}

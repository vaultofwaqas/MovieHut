//
//  MovieListViewModelImpl.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import Foundation

typealias MovieListViewModelViewSetup = (MovieListViewModelImpl.ViewSetup) -> Void

protocol MovieListViewModel {
    var viewSetup: MovieListViewModelViewSetup? { get set }
    
    // MARK: - Variable Protocols
    var movies: [Movie] { get set }
    
    // MARK: - Lifecycle Protocols
    func viewModelDidLoad()
    func viewModelWillAppear()
    func viewModelWillDisappear()
    
    // MARK: - Route Protocols
    
    // MARK: - API Protocols
    
    // MARK: - Logic Protocols
}

class MovieListViewModelImpl {

    private let router: MovieListRouter
    
    var viewSetup: MovieListViewModelViewSetup?
    
    // MARK: - Variables
    var movieManager: MovieManager
    var movies: [Movie] = []
    
    // MARK: - Initializer
    init(router: MovieListRouter) {
        self.router = router
        movieManager = MovieManager()
    }
    
    // MARK: - For all of your viewBindings
    enum ViewSetup {
        case setupNavigation
        case setupView
        case showLoader
        case hideLoader
        case showSuccessMessage(withMessage: String)
        case showErrorMessage(withMessage: String)
    }
}

// MARK: - Lifecycle Functions
extension MovieListViewModelImpl: MovieListViewModel {
    func viewModelDidLoad() {
        viewSetup?(.setupNavigation)
        viewSetup?(.setupView)
        movieListApi(setMovieListPayload())
    }
    
    func viewModelWillAppear() {}
    
    func viewModelWillDisappear() {}
}

// MARK: - Route Functions
extension MovieListViewModelImpl {

}

// MARK: - API Functions
extension MovieListViewModelImpl {
    
    func setMovieListPayload() -> ServicePayload {
        var payload = ServicePayload()
        payload.setPayload(baseUrl: ServiceConstants.movieListUrl, apiEndPoint: .movieList(ServiceConstants.apiKey), requestType: .get)
        return payload
    }
    
    func movieListApi(_ withPayload: ServicePayload) {
        movieManager.movieListApi(payload: withPayload) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieBase):
                self.movies = movieBase.movies ?? []
            case .failure: break
            }
        }
    }
}

// MARK: - Logic Functions
extension MovieListViewModelImpl {

}

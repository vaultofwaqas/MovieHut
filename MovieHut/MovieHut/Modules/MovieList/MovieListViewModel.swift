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
    var movieSections: [MovieListSection] { get set }
    var movies: [Movie] { get set }
    
    // MARK: - Lifecycle Protocols
    func viewModelDidLoad()
    func viewModelWillAppear()
    func viewModelWillDisappear()
    
    // MARK: - Route Protocols
    func goToMovieDetail(_ movie: Movie)
    
    // MARK: - API Protocols
    
    // MARK: - Logic Protocols
    func handlePaging(_ itemCount: Int) -> Bool
}

class MovieListViewModelImpl {

    private let router: MovieListRouter
    
    var viewSetup: MovieListViewModelViewSetup?
    
    // MARK: - Variables
    var currentPage: Int = 1
    let pageLimit: Int = 1000
    
    var movieManager: MovieManager
    var movieSections: [MovieListSection] = []
    var movies: [Movie] = []
    
    // MARK: - Initializer
    init(router: MovieListRouter) {
        self.router = router
        movieManager = MovieManager()
        movieListApi(setMovieListPayload(currentPage))
    }
    
    // MARK: - For all of your viewBindings
    enum ViewSetup {
        case setupNavigation
        case setupView
        case showLoader
        case hideLoader
        case reloadView
    }
}

// MARK: - Lifecycle Functions
extension MovieListViewModelImpl: MovieListViewModel {
    func viewModelDidLoad() {
        viewSetup?(.setupNavigation)
        viewSetup?(.setupView)
    }
    
    func viewModelWillAppear() {}
    
    func viewModelWillDisappear() {}
}

// MARK: - Route Functions
extension MovieListViewModelImpl {
    func goToMovieDetail(_ movie: Movie) {
        router.goToMovieDetail(movie)
    }
}

// MARK: - API Functions
extension MovieListViewModelImpl {
    
    func setMovieListPayload(_ currentPage: Int) -> ServicePayload {
        var payload = ServicePayload()
        payload.setPayload(baseUrl: ServiceConstants.movieListUrl, apiEndPoint: .movieList(ServiceConstants.apiKey, currentPage), requestType: .get)
        return payload
    }
    
    func movieListApi(_ withPayload: ServicePayload) {
        if movies.isEmpty { viewSetup?(.showLoader) }
        movieManager.movieListApi(payload: withPayload) { [weak self] result in
            guard let self = self else { return }
            self.viewSetup?(.hideLoader)
            switch result {
            case .success(let movieBase): self.populateList(movieBase)
            case .failure: break
            }
        }
    }
}

// MARK: - Logic Functions
extension MovieListViewModelImpl {
    
    private func populateList(_ movieBase: MovieBase) {
        movieSections = [.movie]
        movies.append(contentsOf: movieBase.movies ?? [])
        viewSetup?(.reloadView)
    }
    
    func handlePaging(_ itemCount: Int) -> Bool {
        if itemCount == movies.count {
            if currentPage < pageLimit {
                currentPage += 1
                movieListApi(setMovieListPayload(currentPage))
                return true
            }
        }
        return false
    }
}

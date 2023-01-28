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
    
    // MARK: - Initializer
    init(router: MovieDetailRouter) {
        self.router = router
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
    }
    
    func viewModelWillAppear() {}
    
    func viewModelWillDisappear() {}
}

// MARK: - Route Functions
extension MovieDetailViewModelImpl {

}

// MARK: - API Functions
extension MovieDetailViewModelImpl {

}

// MARK: - Logic Functions
extension MovieDetailViewModelImpl {

}

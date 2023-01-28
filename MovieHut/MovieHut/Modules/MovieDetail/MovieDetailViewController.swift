//
//  LaunchGood
//
//  Copyright © 2022 Bismillah Ar-Rahman Ar-Raheem. All rights reserved.
//

import UIKit

class MovieDetailViewController: BaseViewController {

    var viewModel: MovieDetailViewModel!
    
    // MARK: - Outlets
    
    // MARK: - Variables
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.viewModelDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewModelWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewModelWillDisappear()
    }
    
    // MARK: - Set / Update Views
    
    // MARK: - Actions
}

// MARK: - Bind Views
extension MovieDetailViewController {
    
    fileprivate func bindViewModel() {
        viewModel.viewSetup = { [weak self] output in
            guard let self = self else { return }
            // handle all your bindings here
            switch output {
            case .setupNavigation: self.setupNavigation()
            case .setupView: self.setupView()
            case .showLoader: self.showLoader()
            case .hideLoader: self.hideLoader()
            }
        }
    }
}

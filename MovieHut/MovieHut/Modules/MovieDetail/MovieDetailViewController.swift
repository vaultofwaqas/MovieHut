//
//  MovieDetailViewController.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import UIKit

class MovieDetailViewController: BaseViewController {

    var viewModel: MovieDetailViewModel!
    
    // MARK: - Outlets
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelMovieDate: UILabel!
    @IBOutlet weak var labelMovieDescription: UILabel!
    
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
    override func setupView() {
        labelMovieTitle.text = viewModel.movie?.originalTitle.orNil
        labelMovieDate.text = viewModel.movie?.releaseDate.orNil
        labelMovieDescription.text = viewModel.movie?.overview.orNil
        KFImageManager.setImage(url: viewModel.movie?.getPosterUrl() ?? "", imageView: imageMovie)
    }
    
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

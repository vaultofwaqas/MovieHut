//
//  MovieListViewController.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import UIKit

class MovieListViewController: BaseViewController {

    var viewModel: MovieListViewModel!
    
    // MARK: - Outlets
    @IBOutlet private var tableview: UITableView!
    
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
    override func setupNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func setupView() {
        setTableViews()
    }
    
    private func setTableViews() {
        tableview.delegate = self
        tableview.dataSource = self
        setupTableViewNib()
    }

    private func setupTableViewNib() {
        tableview.register(cellType: MovieRow.self)
    }
    
    public func reloadTableView() {
        DispatchQueue.main.async {
            self.tableview.reloadData()
            self.tableview.layoutIfNeeded()
        }
    }
    
    // MARK: - Actions
}

// MARK: - Bind Views
extension MovieListViewController {
    
    fileprivate func bindViewModel() {
        viewModel.viewSetup = { [weak self] output in
            guard let self = self else { return }
            //handle all your bindings here
            switch output {
            case .setupNavigation:
                self.setupNavigation()
            case .setupView:
                self.setupView()
            case .showLoader:
                self.showLoader()
            case .hideLoader:
                self.hideLoader()
            case .showSuccessMessage(let withMessage):
                self.showSuccessMessage(withMessage)
            case .showErrorMessage(let withMessage):
                self.showErrorMessage(withMessage)
            }
        }
    }
}

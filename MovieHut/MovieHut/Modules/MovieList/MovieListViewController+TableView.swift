//
//  MovieListViewController.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import UIKit

// MARK: - TableView Delegate
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToMovieDetail(viewModel.movies[indexPath.row])
    }
}

// MARK: - TableView DataSource
extension MovieListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.movieSections.count
    }
    
    // MARK: - TableView Cells DataSources
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.movieSections[section] {
        case .movie: return viewModel.movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.movieSections[indexPath.section] {
        case .movie: return movieCell(tableView, indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch viewModel.handlePaging(indexPath.item + 1) {
        case true:
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(100))

            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        case false:
            tableView.tableFooterView = nil
            tableView.tableFooterView?.isHidden = true
        }
    }
}

// MARK: - TableView Cell Views
extension MovieListViewController {
    
    public func movieCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: MovieRow.self, for: indexPath)
        cell.bind(viewModel.movies[indexPath.row])
        return cell
    }
}

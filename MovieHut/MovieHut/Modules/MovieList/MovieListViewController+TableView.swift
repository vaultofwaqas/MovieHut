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
}

// MARK: - TableView Cell Views
extension MovieListViewController {
    
    public func movieCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: MovieRow.self, for: indexPath)
        cell.bind(viewModel.movies[indexPath.row])
        return cell
    }
}

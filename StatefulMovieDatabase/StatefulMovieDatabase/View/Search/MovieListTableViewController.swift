//
//  MovieListTableViewController.swift
//  StatefulMovieDatabase
//
//  Created by Karl Pfister on 2/9/22.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    // MARK: - Properties
    var viewModel: MediaSearchViewModel!
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MediaSearchViewModel()
        viewModel.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = viewModel.movies[indexPath.row]
        cell.setConfiguration(with: movie)
        
        return cell
    }
    
}

extension MovieListTableViewController: MediaSearchViewModelDelegate {
    func searchResultsLoadedSuccessfully() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func encountered(_ error: Error) {
        print(error)
        ///Add alert controller to display the error to the user
    }
}

extension MovieListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text else {
            print("No text entered.")
            return
        }
        
        viewModel.searchWith(text: searchTerm)
    }
}

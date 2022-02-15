//
//  HomePageViewController.swift
//  StatefulMovieDatabase
//
//  Created by Arian Mohajer on 2/15/22.
//

import Foundation
import UIKit

class HomePageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchViewController()
    }
    
    private func setUpSearchViewController() {
        let storyboard = UIStoryboard(name: "MediaSearchViewController", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as? MovieListTableViewController
        navigationItem.searchController = UISearchController(searchResultsController: viewController)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.delegate = viewController
    }
}

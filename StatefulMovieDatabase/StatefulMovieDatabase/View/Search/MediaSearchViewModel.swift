//
//  MediaSearchViewModel.swift
//  StatefulMovieDatabase
//
//  Created by Arian Mohajer on 2/15/22.
//

import Foundation

protocol MediaSearchViewModelDelegate: AnyObject {
    func searchResultsLoadedSuccessfully()
    func encountered(_ error: Error)
}

class MediaSearchViewModel {
    var movies: [Movie] = []
    let dataProvider = MediaSearchDataProvider()
    weak var delegate: MediaSearchViewModelDelegate?
    
    func searchWith(text: String) {
        dataProvider.fetchMoviesWith(searchTerm: text) { [weak self] result in
            switch result {
                
            case .success(let list):
                self?.movies = list.results
                self?.delegate?.searchResultsLoadedSuccessfully()
            case .failure(let error):
                print(error)
                self?.delegate?.encountered(error)
            }
        }
    }
}


struct MediaSearchDataProvider {
    func fetchMoviesWith(searchTerm: String, completion: @escaping (Result<TopLevelDictionary, NetworkError>) -> Void) {
        NetworkController.fetchMovieWith(searchTerm: searchTerm, completion: completion)
        
    }
}

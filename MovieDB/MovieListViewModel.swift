//
//  MoviewListViewModel.swift
//  MovieDB
//
//  Created by Parth Vasavada on 24/04/21.
//

import Foundation

class MovieListViewModel: DataBinding {
    
    var dataBinding: (() -> Void)?
    
    /// List of movies
    lazy var movies: [Movie] = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.dataBinding?()
            }
        }
    }
    
    init() {
        self.fetchNowPlayingMovies()
    }
    
   private func fetchNowPlayingMovies() {
        let allMovies = CoreDataManager.fetchAllData()
        if allMovies.isEmpty {
            self.getNowPlayingMovieList()
        } else {
            self.movies = allMovies
        }
    }
    
    /// Fetches latest movie list from server.
    
    func getNowPlayingMovieList() {
        print("===== Downloading Movies ========")
        guard let url = URL(string: Constants.urlString) else { return }
        
        APIRequestManager().getMovieList(for: url) { result in
            
            switch result {
            
            case .success(let movies):
                CoreDataManager.insertDataToCoreData(movies) { isSaved in
                    if isSaved {
                        self.movies = CoreDataManager.fetchAllData()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
            
        }
    }
}

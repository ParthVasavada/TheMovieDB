//
//  MoviesDataSource.swift
//  MovieDB
//
//  Created by Parth Vasavada on 24/04/21.
//

import Foundation
import UIKit

class MoviesDataSource: NSObject, UICollectionViewDataSource {
    
    lazy var movies: [Movie]? = nil
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let movie = self.movies?[indexPath.row],
              let moviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            fatalError("Unable to deque Cell")
        }
        
        guard let movieTitle = movie.title,
              let moviePosterPath = movie.posterImagePath else {
            fatalError("Unable to retrive value from DB.")
        }
        
        moviewCell.updateTitle(movieTitle)
        moviewCell.updateFavouriteMovie(isFavourite: movie.favourite)
        
        if let movieImage = movie.posterImage {
            moviewCell.updateMovieImage(movieImage)
        } else {
            let cellVieModel = MovieCellViewModel()
            cellVieModel.posterImagePath = moviePosterPath
            cellVieModel.dataBinding = { movieImage in
                DispatchQueue.main.async {
                    moviewCell.updateMovieImage(movieImage)
                }
                movie.posterImageData = movieImage.jpegData(compressionQuality: 1.0)
                try? movie.managedObjectContext?.save()
            }
        }
        return moviewCell
    }
}

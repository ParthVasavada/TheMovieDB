//
//  ViewController.swift
//  MovieDB
//
//  Created by Parth Vasavada on 24/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var movieDBCollectionView: UICollectionView!
    {
        didSet {
            self.movieDBCollectionView.register(UINib(nibName: MovieCollectionViewCell.identifier, bundle: Bundle.main), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        }
    }
    
    private lazy var viewModel = MovieListViewModel()
    private lazy var dataSource = MoviesDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.nowPlayingTitle
        
        self.initialSetup()
    }
    
    private func initialSetup() {
        
        self.movieDBCollectionView.dataSource = self.dataSource
        self.movieDBCollectionView.delegate = self
        
        viewModel.dataBinding = { [weak self] in
            self?.dataSource.movies = self?.viewModel.movies
            self?.movieDBCollectionView.reloadData()
        }
    }
    
    @IBAction private func retriveFreshMovieList() {
        CoreDataManager.deleteAllData { [weak self] isSuccessfull in
            if isSuccessfull {
                self?.viewModel.movies = []
                self?.viewModel.getNowPlayingMovieList()
            }
        }
        
    }
    
}

// MARK: - UICollectionViewDelegate
extension ViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedMovie = self.viewModel.movies[indexPath.row]
        
        let message = selectedMovie.favourite ? Constants.unFavouriteTitle : Constants.favouriteTitle
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: Constants.YesText, style: .default , handler:{ (UIAlertAction)in
            selectedMovie.favourite = !selectedMovie.favourite
            if let _ = try? selectedMovie.managedObjectContext?.save() {
                self.movieDBCollectionView.reloadData()
            }
        }))
        
        alert.addAction(UIAlertAction(title: Constants.cancelText, style: .cancel, handler:{ (UIAlertAction)in
            alert.dismiss(animated: true)
        }))
        
        self.present(alert, animated: true)
    }
}

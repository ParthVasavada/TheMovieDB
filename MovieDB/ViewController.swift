//
//  ViewController.swift
//  MovieDB
//
//  Created by Parth Vasavada on 24/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var moviewDBCollectionView: UICollectionView!
    {
        didSet {
            self.moviewDBCollectionView.register(UINib(nibName: MoviewCollectionViewCell.identifier, bundle: Bundle.main), forCellWithReuseIdentifier: MoviewCollectionViewCell.identifier)
        }
    }
    
    private lazy var viewModel = MoviewListViewModel()
    private lazy var dataSource = MoviesDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.nowPlayingTitle
        
        self.initialSetup()
    }
    
    private func initialSetup() {
        
        self.moviewDBCollectionView.dataSource = self.dataSource
        self.moviewDBCollectionView.delegate = self
        
        viewModel.dataBinding = { [weak self] in
            self?.dataSource.movies = self?.viewModel.movies
            self?.moviewDBCollectionView.reloadData()
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
                self.moviewDBCollectionView.reloadData()
            }
        }))
        
        alert.addAction(UIAlertAction(title: Constants.cancelText, style: .cancel, handler:{ (UIAlertAction)in
            alert.dismiss(animated: true)
        }))
        
        self.present(alert, animated: true)
    }
}

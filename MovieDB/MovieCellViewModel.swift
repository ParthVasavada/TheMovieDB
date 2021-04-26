//
//  MovieCellViewModel.swift
//  MovieDB
//
//  Created by Parth Vasavada on 25/04/21.
//

import Foundation
import UIKit
class MovieCellViewModel: DataBinding {
    
    var dataBinding: ((UIImage) -> Void)?
    
    /// Poster Image path or a movie, using that an image is getting downloaded.
    var posterImagePath: String? {
        didSet {
            guard let imagePath = self.posterImagePath else { return }
            self.downloadImage(forPath: imagePath)
        }
    }
    
    private func downloadImage(forPath: String) {
        
        guard let url = URL(string: "\(Constants.imageEndpoint)\(forPath)") else { return }
        APIRequestManager().downloadMovieImage(url: url) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.dataBinding?(image)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

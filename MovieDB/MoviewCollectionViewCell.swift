//
//  MoviewCollectionViewCell.swift
//  MovieDB
//
//  Created by Parth Vasavada on 24/04/21.
//

import UIKit

class MoviewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MoviewCollectionViewCell"

    @IBOutlet private weak var moviewImageView: UIImageView!
    
    @IBOutlet private weak var moviewTitleLabel: UILabel!
    
    @IBOutlet private weak var favouriteLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /**
        Update movie Title.
     - parameter title: Title of a movie.
     */
    
    func updateTitle(_ title: String) {
        self.moviewTitleLabel.text = title
    }
    
    /**
        Update movie poster image.
     - parameter image: Poster Image of a movie.
     */
    
    func updateMovieImage(_ image: UIImage) {
        self.moviewImageView.image = image
    }
    
    /**
        Update movie is user has marked is favourite or unfavourite.
     - parameter isFavourite: Favourite or unfavourite bool value.
     */
    
    func updateFavouriteMovie(isFavourite: Bool) {
        self.favouriteLabel.isHidden = !isFavourite
    }
    
}

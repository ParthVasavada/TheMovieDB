//
//  AppConstants.swift
//  MovieDB
//
//  Created by Parth Vasavada on 24/04/21.
//

import Foundation

enum Constants {
    
    static let nowPlayingTitle = "Now Playing"
    
    static let movieEndPoints = "https://api.themoviedb.org/3/movie/now_playing"
    static let imageEndpoint = "https://image.tmdb.org/t/p/w200/"
    
    static let apiKey = "34c902e6393dc8d970be5340928602a7"
    static let additionalParams = "&language=en-US&page=1"
    
    static let urlString = "\(Self.movieEndPoints)?api_key=\(Self.apiKey)\(Self.additionalParams)"
    
    static let getMethod = "Get"
    
    static let favouriteTitle = "Do you mark this movie favourite?"
    
    static let unFavouriteTitle = "Do you want to make this movie unfavourite?"
    
    static let YesText = "Yes"
    
    static let cancelText = "Cancel"
    
    static let imageError = "Unable to create Image."
    
    static let dbTitle = "MovieDB"
    
    static let entityName = "Movie"
    
    // Entity properties.
    enum Keys: String {
        case adult = "adult"
        case id = "id"
        case originalTitle = "originalTitle"
        case overview = "overview"
        case popularity = "popularity"
        case releaseDate = "releaseDate"
        case title = "title"
        case posterImagePath = "posterImagePath"
        case favourite = "favourite"
    }
}

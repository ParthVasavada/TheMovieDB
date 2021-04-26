//
//  Models.swift
//  MovieDB
//
//  Created by Parth Vasavada on 24/04/21.
//

struct MovieDBResponse: Decodable {
    
    let movies: [MovieModel]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct MovieModel: Decodable {
    
    let adult: Bool
    let id: Double?
    let originalTitle: String
    let overview: String
    let popularity: Double?
    let releaseDate: String
    let title: String
    let posterImagePath: String
    
    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case originalTitle = "original_title"
        case overview
        case popularity
        case releaseDate = "release_date"
        case title
        case posterImagePath = "poster_path"
    }
    
}


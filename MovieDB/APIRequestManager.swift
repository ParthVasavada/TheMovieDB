//
//  MovieFetcher.swift
//  MovieDB
//
//  Created by Parth Vasavada on 24/04/21.
//
import Foundation
import UIKit

class APIRequestManager: NSObject {
     
    typealias responseHandler = (Result<[MovieModel], AppError>) -> Void
    typealias imageDownloadHandler = (Result<UIImage, AppError>) -> Void
    
    /**
     Retrive movie list from The MovieDb.
     
     - parameters:
        - url: URL to download movies.
        - completion: Completion handler to notify caller after response came.
     
     */
    
    func getMovieList(for url: URL , completion: @escaping responseHandler) {
        
        var urlRequest = URLRequest(url: url )
        urlRequest.httpMethod = Constants.getMethod
    
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
          
            if let error = error {
                completion(.failure(.customError(description: error.localizedDescription)))
            }
            
            guard let jsonData = data,
                  let movies = try? JSONDecoder().decode(MovieDBResponse.self, from: jsonData).movies else {
                completion(.failure(.parsingError))
                return
            }
            
            completion(.success(movies))
            
        }.resume()
    }
    
    /**
     Download Image from server.
     
     - parameters:
        - url: URL to download image.
        - completionHandler: Completion handler to notify caller after response came.
     
     */
    
    func downloadMovieImage(url: URL, completionHandler: @escaping imageDownloadHandler) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completionHandler(.failure(.customError(description: error.localizedDescription)))
            }
            
            guard let imageData = data,
                  let movieImage = UIImage(data: imageData) else {
                completionHandler(.failure(.customError(description: Constants.imageError)))
                return
            }
            
            completionHandler(.success(movieImage))
            
        }.resume()
        
    }
    
}

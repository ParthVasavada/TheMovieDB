//
//  Movie+CoreDataProperties.swift
//  MovieDB
//
//  Created by Parth Vasavada on 25/04/21.
//
//

import Foundation
import CoreData
import UIKit

extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var id: Double
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterImageData: Data?
    @NSManaged public var posterImagePath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var favourite: Bool

}

extension Movie {
    var posterImage: UIImage? {
        guard let imageData = self.posterImageData else { return nil }
        return UIImage(data: imageData)
    }
}

extension Movie : Identifiable {

}

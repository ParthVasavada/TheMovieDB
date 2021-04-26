//
//  AppUtilities.swift
//  MovieDB
//
//  Created by Parth Vasavada on 24/04/21.
//

import UIKit


enum AppError: Error {
    case parsingError
    case customError(description: String)
}

extension UIColor {
    
    // App theme color, can be used directly.
    static var  appThemeColor: UIColor {
        return UIColor(red: 0.0/255.0, green: 35.0/255.0, blue: 80.0/255.0, alpha: 1.0)
    }
}

protocol DataBinding {
    associatedtype BindingType
    var dataBinding: BindingType { get set }
}

//
//  RepositoryError.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import Foundation

public enum RepositoryError: Error {
    case genericError
    case mappingError
    case noResults
}

//
//  RemoteDataSourceError.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import Foundation

public enum RemoteDataSourceError: Error {
    case jsonDecodingError(Error)
    case genericServerError
    case noData
    case badRequest
}

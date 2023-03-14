//
//  ProductDataSource.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import Foundation

public protocol ProductsRemoteDataSourceProtocol {
    func getProductList(completionHandler: @escaping (Result<[ProductDTO], RemoteDataSourceError>) -> Void)
}

public class ProductsRemoteDataSource: ProductsRemoteDataSourceProtocol {

    public init() {}
    
    public func getProductList(completionHandler: @escaping (Result<[ProductDTO], RemoteDataSourceError>) -> Void) {
        guard let url = URL(string: "https://mocki.io/v1/6bb59bbc-e757-4e71-9267-2fee84658ff2") else {
            return completionHandler(.failure(.badRequest))
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in

            guard (error == nil) else { return completionHandler(.failure(.genericServerError)) }
            guard let data = data else { return completionHandler(.failure(.noData)) }

            do {
                let products = try JSONDecoder().decode([ProductDTO].self, from: data)
                completionHandler(.success(products))
            } catch {
                completionHandler(.failure(.jsonDecodingError(error)))
            }

        }.resume()
    }
}

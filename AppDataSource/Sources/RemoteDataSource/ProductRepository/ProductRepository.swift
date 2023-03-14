//
//  ProductRepository.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import Foundation

public protocol ProductRepositoryProtocol {
    func getProductList(completion: @escaping (Result<[Product], RepositoryError>) -> Void)
}

public class ProductRepository: ProductRepositoryProtocol {
    private let remoteDataSource: ProductsRemoteDataSourceProtocol

    public init(remoteDataSource: ProductsRemoteDataSourceProtocol = ProductsRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }

    public func getProductList(completion: @escaping (Result<[Product], RepositoryError>) -> Void) {
        remoteDataSource.getProductList { result in
            switch result {
            case .success(let dto):
                do {
                    let productList = try ProductMapper.map(dto)
                    completion(.success(productList))
                } catch {
                    completion(.failure(.mappingError))
                }
            case .failure:
                completion(.failure(.genericError))
            }
        }
    }
}

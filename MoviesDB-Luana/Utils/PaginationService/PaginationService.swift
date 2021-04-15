//
//  PaginationManager.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 14/04/21.
//

import Combine
import Foundation

protocol PaginationServiceType {
    var isPaginating: Bool { get }
    func performPagination<T: Decodable>(request: URLRequest, decodingType: T.Type) -> AnyPublisher<PaginatedResponse<T>, Error>
}

class PaginationService: PaginationServiceType, MoviesDBNetworkClientType {
    var session: URLSession = URLSession.shared
    var isPaginating = false

    func performPagination<T: Decodable>(request: URLRequest, decodingType: T.Type) -> AnyPublisher<PaginatedResponse<T>, Error> {
        return Future { seal in
            self.isPaginating = true
            self.fetch(with: request) { json in
                json as? PaginatedResponse<T>
            } completion: { response in
                switch response {
                case .failure(let error):
                    seal(.failure(error))
                case .success(let response):
                    seal(.success(response))
                }
            }
        }
        .handleEvents(receiveOutput: { _ in
            self.isPaginating = false
        })
        .eraseToAnyPublisher()
    }
}

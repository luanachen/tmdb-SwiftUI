//
//  PaginationManager.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 14/04/21.
//

import Combine
import Foundation

public protocol PaginationServiceType {
    var isPaginating: Bool { get }
    func performPagination<T: Decodable>(request: URLRequest, decodingType: T.Type) -> AnyPublisher<PaginatedResponse<T>, Error>
}

public class PaginationService: PaginationServiceType, MoviesDBNetworkClientType {
    public var session: URLSession = URLSession.shared
    public var isPaginating = false
    
    public init() {}
    
    public func performPagination<T: Decodable>(request: URLRequest, decodingType: T.Type) -> AnyPublisher<PaginatedResponse<T>, Error> {
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

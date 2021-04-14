//
//  PaginationManager.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 14/04/21.
//

import Combine
import Foundation

protocol PaginationServiceType {
    func performPagination<T: Decodable>(endPoint: MoviesDBEndpointType, decodingType: T.Type) -> AnyPublisher<PaginatedResponse<T>, Error>
}

class PaginationService: PaginationServiceType, MoviesDBNetworkClientType {
    var session: URLSession = URLSession.shared

    func performPagination<T: Decodable>(endPoint: MoviesDBEndpointType, decodingType: T.Type) -> AnyPublisher<PaginatedResponse<T>, Error> {
        let endPoint = endPoint
        var request = endPoint.request
        request.httpMethod = HTTPMethodType.get.rawValue

       return Future { seal in
        self.fetch(with: request) { json in
                return json as? PaginatedResponse<T>
            } completion: { response in
                switch response {
                case .failure(let error):
                    seal(.failure(error))
                case .success(let response):
                    seal(.success(response))
                }
            }
        }.eraseToAnyPublisher()
    }
}

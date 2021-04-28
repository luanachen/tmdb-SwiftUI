//
//  ShowsServiceMock.swift
//  MoviesDB-LuanaTests
//
//  Created by Luana Chen Chih Jun on 16/04/21.
//

import Commons
import Combine
@testable import MoviesDB_Luana

class ShowsServiceMock: ShowsServiceType {
    let paginatedResponse = ResponseLoader.getResponseFrom(resource: "popularTV", decodable: PaginatedResponse<Show>.self)
    let showDetailResponse = ResponseLoader.getResponseFrom(resource: "showDetail", decodable: ShowDetail.self)
    let creditResponse = ResponseLoader.getResponseFrom(resource: "showCredits", decodable: Credit.self)
    
    var isPaginating: Bool = false
    var isRequestSuccess = true

    func fetchShowList(endpoint: ShowsEndpoints) -> AnyPublisher<PaginatedResponse<Show>, Error> {
        return Future { seal in
            if self.isRequestSuccess {
                seal(.success(self.paginatedResponse))
            } else {
                seal(.failure(MovieDBError.somethingWentWrong))
            }
        }
        .eraseToAnyPublisher()
    }

    func fetchShowDetail(tvId: String) -> AnyPublisher<ShowDetail, Error> {
        return Future { seal in
            if self.isRequestSuccess {
                seal(.success(self.showDetailResponse))
            } else {
                seal(.failure(MovieDBError.somethingWentWrong))
            }
        }
        .eraseToAnyPublisher()
    }

    func fetchShowCast(tvId: String) -> AnyPublisher<Credit, Error> {
        return Future { seal in
            if self.isRequestSuccess {
                seal(.success(self.creditResponse))
            } else {
                seal(.failure(MovieDBError.somethingWentWrong))
            }
        }
        .eraseToAnyPublisher()
    }

}


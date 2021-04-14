import Combine
import Foundation

protocol ShowsRepositoryProtocol {
    func fetchShowList(endpoint: ShowsEndpoints) -> AnyPublisher<PaginatedResponse<Show>, Error>
    func fetchShowDetail(tvId: String) -> AnyPublisher<ShowDetail, Error>
    func fetchShowCast(tvId: String) -> AnyPublisher<Credit, Error>
}

class ShowsRepository: ShowsRepositoryProtocol, MoviesDBNetworkClientType {
    let session: URLSession = URLSession.shared

    let paginationService: PaginationServiceType

    init(paginationService: PaginationServiceType = PaginationService()) {
        self.paginationService = paginationService
    }

    func fetchShowList(endpoint: ShowsEndpoints) -> AnyPublisher<PaginatedResponse<Show>, Error> {
        let endPoint = endpoint
        var request = endPoint.request
        request.httpMethod = HTTPMethodType.get.rawValue

        return paginationService.performPagination(endPoint: endpoint, decodingType: Show.self)
    }

    func fetchShowDetail(tvId: String) -> AnyPublisher<ShowDetail, Error> {
        let endPoint = ShowsEndpoints.detail(tvId)
        var request = endPoint.request
        request.httpMethod = HTTPMethodType.get.rawValue

        return Future { seal in
         self.fetch(with: request) { json in
                 return json as? ShowDetail
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
    
    func fetchShowCast(tvId: String) -> AnyPublisher<Credit, Error> {
        let endPoint = ShowsEndpoints.cast(tvId)
        var request = endPoint.request
        request.httpMethod = HTTPMethodType.get.rawValue

        return Future { seal in
         self.fetch(with: request) { json in
                 return json as? Credit
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

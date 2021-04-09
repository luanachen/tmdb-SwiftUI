import Combine
import Foundation
import NetworkHelper

protocol ShowsRepositoryProtocol {
    func fetchShowList(endpoint: ShowsEndpoints) -> AnyPublisher<ShowList, Error>
    func fetchShowDetail(tvId: String) -> AnyPublisher<ShowDetail, Error>
    func fetchShowCast(tvId: String) -> AnyPublisher<Credit, Error>
}

class ShowsRepository: ShowsRepositoryProtocol, APIClient {
    let session: URLSession = URLSession.shared

    func fetchShowList(endpoint: ShowsEndpoints) -> AnyPublisher<ShowList, Error> {
        let endPoint = endpoint
        var request = endPoint.request
        request.httpMethod = HTTPMethod.get.rawValue

       return Future { seal in
        self.fetch(with: request) { json in
                return json as? ShowList
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

    func fetchShowDetail(tvId: String) -> AnyPublisher<ShowDetail, Error> {
        let endPoint = ShowsEndpoints.detail(tvId)
        var request = endPoint.request
        request.httpMethod = HTTPMethod.get.rawValue

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
        request.httpMethod = HTTPMethod.get.rawValue

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

import Foundation
import NetworkHelper

protocol ShowsRepositoryProtocol {
    func fetchShowList(endpoint: ShowsEndpoints, completion: @escaping (Result<ShowList, APIError>) -> Void)
    func fetchShowDetail(tvId: String, completion: @escaping (Result<ShowDetail, APIError>) -> Void)
    func fetchShowCast(tvId: String, completion: @escaping (Result<Credit, APIError>) -> Void)
}

class ShowsRepository: ShowsRepositoryProtocol, APIClient {
    var session: URLSession = URLSession.shared

    func fetchShowList(endpoint: ShowsEndpoints, completion: @escaping (Result<ShowList, APIError>) -> Void) {
        let endPoint = endpoint
        var request = endPoint.request
        request.httpMethod = HTTPMethod.get.rawValue

        fetch(with: request, decode: { json in
            guard let result = json as? ShowList else { return nil }
            return result
        }, completion: completion)
    }

    func fetchShowDetail(tvId: String, completion: @escaping (Result<ShowDetail, APIError>) -> Void) {
        let endPoint = ShowsEndpoints.detail(tvId)
        var request = endPoint.request
        request.httpMethod = HTTPMethod.get.rawValue

        fetch(with: request, decode: { json in
            guard let result = json as? ShowDetail else { return nil }
            return result
        }, completion: completion)
    }
    
    
    func fetchShowCast(tvId: String, completion: @escaping (Result<Credit, APIError>) -> Void) {
        let endPoint = ShowsEndpoints.cast(tvId)
        var request = endPoint.request
        request.httpMethod = HTTPMethod.get.rawValue

        fetch(with: request, decode: { json in
            guard let result = json as? Credit else { return nil }
            return result
        }, completion: completion)
    }
}

import Foundation
import NetworkHelper

enum ShowsEndpoints {
    case popularTVShows
    case onTv
    case airingToday
    case topRated
    case image(String)
    case detail(String)
    case cast(String)
}

extension ShowsEndpoints: EndpointType {
    private var apiKey: String {
        "d26d586dbfdee567a78223358cc2512d"
    }

    var base: String {
        switch self {
        case .popularTVShows, .onTv, .airingToday, .topRated, .detail, .cast:
            return "https://api.themoviedb.org"
        case .image:
            return "https://image.tmdb.org"
        }
    }

    var path: String {
        switch self {
        case .popularTVShows, .onTv, .airingToday, .topRated, .detail, .cast:
            return "/3/tv"
        case .image:
            return "/t/p/w500"
        }
    }

    var pathparam: String? {
        switch self {
        case .popularTVShows: return "/popular"
        case .onTv: return "/airing_today"
        case .airingToday: return "/on_the_air"
        case .topRated: return "/top_rated"
        case .image(let posterPath): return "\(posterPath)"
        case .detail(let tvId): return "/\(tvId)"
        case .cast(let tvId): return "/\(tvId)/credits"
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .popularTVShows, .onTv, .airingToday, .topRated, .detail, .cast:
            var queryItems: [URLQueryItem] = []
            let key = URLQueryItem(name: "api_key", value: apiKey)
            let language = URLQueryItem(name: "language", value: "en-US")
            let page = URLQueryItem(name: "page", value: "1")
            let querys = [key, language, page]
            querys.forEach {
                queryItems.append($0)
            }
            return queryItems
        case .image:
            return nil
        }
    }
}

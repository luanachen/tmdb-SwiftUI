import Foundation

enum ShowsEndpoints {
    case popularTVShows(String)
    case onTv(String)
    case airingToday(String)
    case topRated(String)
    case image(String)
    case detail(String)
    case cast(String)
}

extension ShowsEndpoints: MoviesDBEndpointType {
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
        var queryItems: [URLQueryItem] = []
        let key = URLQueryItem(name: "api_key", value: apiKey)
        let language = URLQueryItem(name: "language", value: "en-US")
        let querys = [key, language]
        querys.forEach {
            queryItems.append($0)
        }

        switch self {
        case .popularTVShows(let pageNumber), .onTv(let pageNumber), .airingToday(let pageNumber),
             .topRated(let pageNumber), .detail(let pageNumber), .cast(let pageNumber):
            let page = URLQueryItem(name: "page", value: pageNumber)
            queryItems.append(page)
            return queryItems
        case .image:
            return nil
        }
    }
}

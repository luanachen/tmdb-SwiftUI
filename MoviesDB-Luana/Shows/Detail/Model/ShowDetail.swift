import Foundation

struct ShowDetail: Decodable {
    let createdBy: [CreatedBy]
    let seasons: [Season]?
}

struct CreatedBy: Decodable {
    let name: String
}

struct Season: Decodable {
    let posterPath: String?
    let seasonNumber: Int?
    let airDate: String?
}

struct Credit: Decodable {
    let cast: [Cast]
}

struct Cast: Decodable {
    let name: String
    let profilePath: String
}

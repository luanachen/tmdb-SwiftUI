import Foundation

struct Show: Decodable, Identifiable {
    let name: String
    let popularity: Double
    let id: Int
    let voteAverage: Double
    let overview: String
    let firstAirDate: String
    let posterPath: String
}

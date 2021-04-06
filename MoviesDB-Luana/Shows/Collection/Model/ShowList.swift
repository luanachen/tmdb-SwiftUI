import Foundation

struct ShowList: Decodable {
    let page: Int
    let results: [Show]
}

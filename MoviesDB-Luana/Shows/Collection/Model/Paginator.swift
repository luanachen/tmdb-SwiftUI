import Foundation

struct Paginator<T:Decodable>: Decodable {
    let page: Int
    let results: [T]
    let totalPages: Int
}

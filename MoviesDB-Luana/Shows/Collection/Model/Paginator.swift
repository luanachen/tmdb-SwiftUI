import Foundation

struct PaginatedResponse<T:Decodable>: Decodable {
    let page: Int
    let results: [T]
    let totalPages: Int
}

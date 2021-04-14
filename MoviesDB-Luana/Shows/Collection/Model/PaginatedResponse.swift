import Foundation

struct PaginatedResponse<T:Decodable>: Decodable {
    let page: Int
    let results: [T]
    let totalPages: Int

    var canPaginate: Bool {
        return page < totalPages
    }

    var isPaginating: Bool {
        return page > 1 && page != totalPages
    }

    var hasCompletedPagination: Bool {
        return page == totalPages
    }
}

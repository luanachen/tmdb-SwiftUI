import Foundation

public struct PaginatedResponse<T:Decodable>: Decodable {
    public let page: Int
    public let results: [T]?
    public let totalPages: Int

    public var canPaginate: Bool {
        page < totalPages
    }

    public var hasCompletedPagination: Bool {
        page == totalPages
    }
}

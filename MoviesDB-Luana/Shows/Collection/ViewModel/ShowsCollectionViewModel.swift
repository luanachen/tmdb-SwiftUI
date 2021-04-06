//
//  ShowsCollectionViewModel.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 03/04/21.
//

import Combine
import Foundation

enum ShowTypes: String, CaseIterable {
    case popular = "Popular"
    case topRated = "Top Rated"
    case onTv = "On TV"
    case airingToday = "Airing today"
}

class ShowsCollectionViewModel: ObservableObject {

    @Published var shows: [Show] = []
    @Published var errorMessage: String?
    @Published var selectedShow: Show?

    private var repository: ShowsRepositoryProtocol

    init(repository: ShowsRepositoryProtocol = ShowsRepository()) {
        self.repository = repository
    }

    func segmentedControlItems() -> [String] {
        var items = [String]()
        for showType in ShowTypes.allCases {
            items.append(showType.rawValue)
        }
        return items
    }

    func didSelectedSegmented(value: String) {
        switch value {
        case "Popular":
            fetchShowsForShow(type: .popular)
        case "Top Rated":
            fetchShowsForShow(type: .topRated)
        case "On TV":
            fetchShowsForShow(type: .onTv)
        case "Airing today":
            fetchShowsForShow(type: .airingToday)
        default:
            break
        }
    }

    private func fetchShowsForShow(type: ShowTypes) {
        switch type {
        case .popular:
            fetchShowsForShow(endpoint: .popularTVShows)
        case .onTv:
            fetchShowsForShow(endpoint: .onTv)
        case .airingToday:
            fetchShowsForShow(endpoint: .airingToday)
        case .topRated:
            fetchShowsForShow(endpoint: .topRated)
        }
    }

    private func fetchShowsForShow(endpoint: ShowsEndpoints) {
        repository.fetchShowList(endpoint: endpoint) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            case .success(let shows):
                self?.shows = shows.results
            }
        }
    }

    func didSelectRow(_ row: Int) {
        selectedShow = shows[row]
    }
}

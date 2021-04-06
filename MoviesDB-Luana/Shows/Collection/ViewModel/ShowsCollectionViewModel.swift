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
    @Published var showAlert: Bool = false

    private var cancellableSet: Set<AnyCancellable> = []
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

    func fetchShowsForShow(type: ShowTypes) {
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
        repository.fetchShowList(endpoint: endpoint)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    self.showAlert.toggle()
                }
            } receiveValue: { showList in
                self.shows = showList.results
            }
            .store(in: &cancellableSet)
    }

    func didSelectRow(_ row: Int) {
        selectedShow = shows[row]
    }
}

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
    @Published var isShowingAlert: Bool = false
    @Published var selectedShowType = ShowTypes.popular

    private var cancellableSet = Set<AnyCancellable>()
    private var repository: ShowsRepositoryProtocol

    var segmentedControlItems: [String] {
        var items = [String]()
        for showType in ShowTypes.allCases {
            items.append(showType.rawValue)
        }
        return items
    }

    init(repository: ShowsRepositoryProtocol = ShowsRepository()) {
        self.repository = repository
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
            .retry(3)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    self.isShowingAlert.toggle()
                }
            } receiveValue: { showList in
                self.shows = showList.results
            }
            .store(in: &cancellableSet)
    }
}

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
    
    @Published var cellViewModels: [ShowCellViewModel] = []
    @Published var errorMessage: String?
    @Published var selectedShow: Show?
    @Published var isShowingAlert: Bool = false
    @Published var selectedShowType = ShowTypes.popular
    
    var currentPage = 1
    var hasCompletedPagination = false
    
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
    
    func onChangePickerView(value: ShowTypes) {
        cellViewModels = []
        currentPage = 1
        fetchShows(for: value)
    }
    
    func onAppearProgressView() {
        currentPage += 1
        fetchShows(for: selectedShowType)
    }
    
    func fetchShows(for ShowType: ShowTypes) {
        switch ShowType {
        case .popular:
            fetchShow(with: .popularTVShows(currentPage.description))
        case .onTv:
            fetchShow(with: .onTv(currentPage.description))
        case .airingToday:
            fetchShow(with: .airingToday(currentPage.description))
        case .topRated:
            fetchShow(with: .topRated(currentPage.description))
        }
    }
    
    private func fetchShow(with endpoint: ShowsEndpoints) {
        guard !hasCompletedPagination, !repository.isPaginating else { return }

        repository.fetchShowList(endpoint: endpoint)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    self.isShowingAlert.toggle()
                }
            } receiveValue: { paginatedResponse in
                paginatedResponse.results?.forEach {
                    let viewModel = ShowCellViewModel(show: $0)
                    self.cellViewModels.append(viewModel)
                }
                
                self.hasCompletedPagination = paginatedResponse.hasCompletedPagination
            }
            .store(in: &cancellableSet)
    }
}

//
//  ShowDetailViewModel.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 07/04/21.
//

import Combine
import Foundation

class ShowDetailViewModel: ObservableObject {

    @Published var show: Show
    @Published var casts: [CastModel] = []
    @Published var creatorsName: String?
    @Published var lastSeason: String?
    @Published var lastSeasonDate: String?
    @Published var lastSeasonPosterURL: URL?
    @Published var isMarkedAsFavorite: Bool = false

    private var cancellableSet = Set<AnyCancellable>()
    private var repository: ShowsRepositoryProtocol

    var posterUrl: URL {
        let endpoint = ShowsEndpoints.image(show.posterPath)
        return URL(string: endpoint.request.url?.absoluteString ?? "")!
    }

    init(show: Show, repository: ShowsRepositoryProtocol = ShowsRepository()) {
        self.show = show
        self.repository = repository
    }

    func fetchShowDetail() {
        repository.fetchShowDetail(tvId: show.id.description)
            .retry(3)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { detail in
                if !detail.createdBy.isEmpty {
                    self.creatorsName = "Created by " + detail.createdBy.map({ $0.name }).joined(separator: ", ")
                }
                if let lasSeason = detail.seasons?.last?.seasonNumber {
                    self.lastSeason = "Season " + lasSeason.description
                }
                if let seasonDate = detail.seasons?.last?.airDate {
                    self.lastSeasonDate = seasonDate.description
                }
                if let seasonPath = detail.seasons?.last?.posterPath {
                    let endpoint = ShowsEndpoints.image(seasonPath)
                    let url = endpoint.request.url
                    self.lastSeasonPosterURL = url
                } else {
                    self.lastSeasonPosterURL = self.posterUrl
                }

                self.fetchCasts()
            }
            .store(in: &cancellableSet)
    }

    func fetchCasts() {
        repository.fetchShowCast(tvId: show.id.description)
            .retry(3)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { credit in
                credit.cast.forEach { cast in
                    let model = CastModel(name: cast.name, profilePath: cast.profilePath)
                    self.casts.append(model)
                }
            }
            .store(in: &cancellableSet)
    }
}

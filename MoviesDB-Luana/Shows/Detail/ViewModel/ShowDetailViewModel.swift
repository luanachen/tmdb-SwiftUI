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
    @Published var creatorsName: String?
    @Published var castName = [String]()
    @Published var castURL = [URL]()

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
                self.fetchCasts()
            }
            .store(in: &cancellableSet)
    }

    func fetchCasts() {
        repository.fetchShowCast(tvId: show.id.description)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { credit in
                self.castName = credit.cast.map({$0.name})

                self.castURL = credit.cast.map({
                    let endpoint = ShowsEndpoints.image($0.profilePath)
                    return endpoint.request.url ?? URL(string: "")!
                })
            }
            .store(in: &cancellableSet)
    }
}

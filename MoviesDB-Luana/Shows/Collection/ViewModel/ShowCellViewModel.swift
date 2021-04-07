//
//  ShowCellViewModel.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 31/03/21.
//

import Combine
import Foundation
import UIKit

class ShowCellViewModel: Identifiable, ObservableObject {
    @Published var image: UIImage?

    private let imageManager = ImageManager()

    private var cancellableSet: Set<AnyCancellable> = []

    let show: Show
    let id: UUID

    init(show: Show) {
        self.id = UUID()
        self.show = show
    }

    func fetchImage() {
        let endpoint = ShowsEndpoints.image(show.posterPath)
        guard let url = URL(string: endpoint.request.url?.absoluteString ?? "") else { return }
        imageManager.loadImage(url: url)
        imageManager.$retrievedImage
            .sink { image in
            image.map { image in
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        .store(in: &cancellableSet)
    }
}


//
//  ShowCellViewModel.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 31/03/21.
//

import Combine
import Foundation
import SwiftUI
import UIKit

class ShowCellViewModel: Identifiable, ObservableObject {
    @Published var image: UIImage?

    private let imageManager = ImageManager()

    private var cancellableSet: Set<AnyCancellable> = []

    let show: Show
    let id: UUID

    var url: URL {
        let endpoint = ShowsEndpoints.image(show.posterPath)
        return URL(string: endpoint.request.url?.absoluteString ?? "")!
    }

    init(show: Show) {
        self.id = UUID()
        self.show = show
    }
}


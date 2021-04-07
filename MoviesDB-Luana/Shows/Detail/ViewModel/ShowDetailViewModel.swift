//
//  ShowDetailViewModel.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 07/04/21.
//

import Foundation
import UIKit

class ShowDetailViewModel: ObservableObject {

    @Published var show: Show

    var url: URL {
        let endpoint = ShowsEndpoints.image(show.posterPath)
        return URL(string: endpoint.request.url?.absoluteString ?? "")!
    }

    init(show: Show) {
        self.show = show
    }
    
}

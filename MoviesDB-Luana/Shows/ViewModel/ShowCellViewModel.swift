//
//  ShowCellViewModel.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 31/03/21.
//

import Foundation

class ShowCellViewModel: Identifiable {
    let show = Show(name: "Movie name",
                    popularity: 7.5,
                    id: 1,
                    voteAverage: 8.9,
                    overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex.",
                    firstAirDate: "Aug 10, 2018", posterPath: "moviedb")
    let id: UUID

    init() {
        self.id = UUID()
    }
}

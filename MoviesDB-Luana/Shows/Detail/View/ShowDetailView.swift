//
//  ShowDetailView.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 03/04/21.
//

import SwiftUI

struct ShowDetailView: View {
    @ObservedObject var viewModel: ShowDetailViewModel

    init(viewModel: ShowDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(
                    url: viewModel.url,
                    placeholder: {
                        Text("Loading ...")
                            .fixedSize()
                    },
                    image: { Image(uiImage: $0).resizable() }
                )
                .frame(height: 211)

                DetailContentView(viewModel: viewModel)
                    .offset(y: -105)
                    .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ShowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let show = Show(name: "Movie name",
                        popularity: 7.5,
                        id: 1,
                        voteAverage: 8.9,
                        overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex.",
                        firstAirDate: "Aug 10, 2018", posterPath: "moviedb")
        let viewModel = ShowDetailViewModel(show: show)
        ShowDetailView(viewModel: viewModel)
    }
}

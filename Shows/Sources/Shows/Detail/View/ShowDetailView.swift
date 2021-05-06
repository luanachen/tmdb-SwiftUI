//
//  ShowDetailView.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 03/04/21.
//

import Commons
import SwiftUI

struct ShowDetailView: View {
    @StateObject var viewModel: ShowDetailViewModel

    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    AsyncImage(
                        url: viewModel.posterUrl,
                        placeholder: {
                            Image.placeholder
                                .resizable()
                                .background(Color.gray)
                        },
                        image: { Image(uiImage: $0).resizable() }
                    )
                    .scaledToFill()
                    .frame(height: 211)
                    .clipped()
                }

                ZStack(alignment: .topTrailing) {
                    DetailContentView(viewModel: viewModel)
                        .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))

                    Text(viewModel.show.voteAverage.description)
                        .font(.system(size: 18, weight: .semibold))
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.white)
                        .background(Color(UIColor.tmdb_green))
                        .clipShape(Circle())
                        .offset(x: -48, y: -20)
                }
                .offset(y: -50)
            }
        }
        .background(Color(UIColor.tmdb_backgroundColor))
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle(Text(""), displayMode: .large)
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
        viewModel.casts = [CastModel(name: "Homer", profilePath: ""),
                           CastModel(name: "Margie", profilePath: "")]
        viewModel.creatorsName = "Created by Steven Spilberg"
        viewModel.lastSeasonPosterURL = URL(string: "www")
        viewModel.lastSeason = "Season 5"
        viewModel.lastSeasonDate = "01/01/2021"
        viewModel.isMarkedAsFavorite = true
        let view = ShowDetailView(viewModel: viewModel)
        return view
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
    }
}

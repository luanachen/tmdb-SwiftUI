//
//  DetailContentView.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 07/04/21.
//

import Commons
import SwiftUI

struct DetailContentView: View {
    @StateObject var viewModel: ShowDetailViewModel

    var body: some View {
        VStack {
            VStack(spacing: 12) {
                HStack {
                    Text("Summary")
                        .font(.system(size: 18))
                        .foregroundColor(Color(UIColor.tmdb_green))
                        .fontWeight(.bold)
                    Spacer()
                }

                HStack {
                    Text(viewModel.show.name)
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                    Spacer(minLength: 20)
                    Button(action: {
                        viewModel.isMarkedAsFavorite.toggle()
                    }, label: {
                        Image(systemName: viewModel.isMarkedAsFavorite ? "heart.fill" : "heart")
                            .foregroundColor(Color(UIColor.tmdb_green))
                    })
                    .frame(width: 24, height: 24)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 6))
                }

                Text(viewModel.show.overview)
                    .font(.system(size: 12))
                    .foregroundColor(.white)

                HStack {
                    Text(viewModel.creatorsName ?? "")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Spacer()
                }

                HStack {
                    Text(viewModel.lastSeason != nil ? "Last Season" : "")
                        .font(.system(size: 18))
                        .foregroundColor(Color(UIColor.tmdb_green))
                        .fontWeight(.bold)
                    Spacer()
                }

                HStack(spacing: 33) {
                    if let url = viewModel.lastSeasonPosterURL {
                        AsyncImage(
                            url: url,
                            placeholder: {
                                Image("placeholder")
                                    .resizable()
                                    .background(Color.gray)
                            },
                            image: { Image(uiImage: $0).resizable() }
                        )
                        .aspectRatio(0.7, contentMode: .fit)
                    }

//                    Spacer()

                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.lastSeason ?? "")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .fontWeight(.bold)

                        Text(viewModel.lastSeasonDate ?? "")
                            .font(.system(size: 10))
                            .foregroundColor(Color(UIColor.tmdb_green))
                            .fontWeight(.semibold)

                        if viewModel.lastSeason != nil {
                            Button("View All Seasons") {
                                print("View All Seasons")
                            }
                            .padding()
                            .frame(height: 30)
                            .font(.system(size: 10, weight: .regular))
                            .background(Color(UIColor.tmdb_green))
                            .foregroundColor(.white)
                            .cornerRadius(5)
                        }
                    }
                }

                Spacer()

                HStack {
                    Text(viewModel.casts.isEmpty ? "" : "Cast")
                        .font(.system(size: 18))
                        .foregroundColor(Color(UIColor.tmdb_green))
                        .fontWeight(.bold)
                    Spacer()
                }
            }
            .padding(EdgeInsets(top: 20, leading: 24, bottom: 0, trailing: 24))

            if !viewModel.casts.isEmpty {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 23) {
                        ForEach(viewModel.casts.indices) { indice in
                            let endpoint = ShowsEndpoints.image(viewModel.casts[indice].profilePath)
                            if let imageUrl = URL(string: endpoint.request.url?.absoluteString ?? "") {
                                VStack {
                                    AsyncImage(
                                        url: imageUrl,
                                        placeholder: {
                                            Image("placeholder")
                                                .resizable()
                                                .background(Color.gray)
                                        },
                                        image: {
                                            Image(uiImage: $0)
                                                .resizable()
                                        }
                                    )
                                    .scaledToFit()
                                    .clipShape(Circle())

                                    Text(viewModel.casts[indice].name)
                                        .font(.system(size: 12))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                    .frame(height: 133)
                    .fixedSize()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                }
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
            }

            Spacer()
        }
        .background(Color(UIColor.tmdb_grey))
        .cornerRadius(15)
        .onAppear(perform: {
            viewModel.fetchShowDetail()
        })
    }
}

struct DetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        let show = Show(name: "Movie name",
                        popularity: 7.5,
                        id: 1,
                        voteAverage: 8.9,
                        overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex.",
                        firstAirDate: "Aug 10, 2018", posterPath: "moviedb")
        let viewModel = ShowDetailViewModel(show: show)
        viewModel.casts = [CastModel(name: "Homer", profilePath: ""),
                           CastModel(name: "Margie", profilePath: ""),
                           CastModel(name: "Lisa", profilePath: "")]
        viewModel.creatorsName = "Created by Steven Spilberg"
        viewModel.lastSeasonPosterURL = URL(string: "www")
        viewModel.lastSeason = "Season 5"
        viewModel.lastSeasonDate = "01/01/2021"
        viewModel.isMarkedAsFavorite = true
        let view = DetailContentView(viewModel: viewModel)
        return view
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
    }
}

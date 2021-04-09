//
//  DetailContentView.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 07/04/21.
//

import SwiftUI

struct DetailContentView: View {
    @StateObject var viewModel: ShowDetailViewModel
    @State var isFavorited: Bool = false

    var body: some View {
        VStack {
            VStack(spacing: 12) {
                HStack {
                    Text("Summary")
                        .font(.system(size: 18))
                        .foregroundColor(Color.init("tmdb-green"))
                        .fontWeight(.bold)
                    Spacer()
                }

                HStack {
                    Text(viewModel.show.name)
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                    Spacer(minLength: 20)
                    Button(action: {
                        isFavorited.toggle()
                    }, label: {
                        Image(systemName: isFavorited ? "heart.fill" : "heart")
                            .foregroundColor(Color.init("tmdb-green"))
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
                        .foregroundColor(Color.init("tmdb-green"))
                        .fontWeight(.bold)
                    Spacer()
                }

                HStack(spacing: 33) {
                    if let url = viewModel.lastSeasonPosterURL {
                        AsyncImage(
                            url: url,
                            placeholder: {
                                Text("Loading ...")
                                    .fixedSize()
                            },
                            image: { Image(uiImage: $0).resizable() }
                        )
                        .aspectRatio(0.7, contentMode: .fit)
                    }

                    Spacer()

                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.lastSeason ?? "")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .fontWeight(.bold)

                        Text(viewModel.lastSeasonDate ?? "")
                            .font(.system(size: 10))
                            .foregroundColor(Color.init("tmdb-green"))
                            .fontWeight(.semibold)

                        if viewModel.lastSeason != nil {
                            Button("View All Seasons") {
                                print("View All Seasons")
                            }
                            .padding()
                            .frame(height: 30)
                            .font(.system(size: 10, weight: .regular))
                            .background(Color.init("tmdb-green"))
                            .foregroundColor(.white)
                            .cornerRadius(5)
                        }
                    }
                }

                Spacer()

                HStack {
                    Text(viewModel.castName.isEmpty ? "" : "Cast")
                        .font(.system(size: 18))
                        .foregroundColor(Color.init("tmdb-green"))
                        .fontWeight(.bold)
                    Spacer()
                }
            }
            .padding(EdgeInsets(top: 20, leading: 24, bottom: 0, trailing: 24))

            if !viewModel.castName.isEmpty {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 23) {
                        ForEach(viewModel.castName.indices, id: \.self) { indice in
                            VStack {
                                AsyncImage(
                                    url: viewModel.castURL[indice],
                                    placeholder: {
                                        Text("Loading ...")
                                            .fixedSize()
                                    },
                                    image: {
                                        Image(uiImage: $0)
                                        .resizable()
                                    }
                                )
                                .scaledToFit()
                                .clipShape(Circle())

                                Text(viewModel.castName[indice])
                                    .font(.system(size: 12))
                                    .foregroundColor(.white)
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
        .background(Color.init("tmdb-grey"))
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
        DetailContentView(viewModel: viewModel)
            .previewLayout(.fixed(width: 325, height: 733))
    }
}

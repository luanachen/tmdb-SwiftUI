//
//  DetailContentView.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 07/04/21.
//

import SwiftUI

struct DetailContentView: View {
    @StateObject var viewModel: ShowDetailViewModel

    var body: some View {
        VStack {
            VStack(spacing: 12) {
                HStack {
                    Text("Summary")
                        .font(.system(size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.1378434002, green: 0.8040757179, blue: 0.3944021463, alpha: 1)))
                        .fontWeight(.bold)
                    Spacer()
                }

                HStack {
                    Text(viewModel.show.name)
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                    Spacer()
                    Button("") {}
                        .background(
                            Image(systemName: "heart")
                                .foregroundColor(Color(#colorLiteral(red: 0.1378434002, green: 0.8040757179, blue: 0.3944021463, alpha: 1)))
                        )
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
                    Text("Last Season")
                        .font(.system(size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.1378434002, green: 0.8040757179, blue: 0.3944021463, alpha: 1)))
                        .fontWeight(.bold)
                    Spacer()
                }

                HStack {
                    AsyncImage(
                        url: viewModel.posterUrl,
                        placeholder: {
                            Text("Loading ...")
                                .fixedSize()
                        },
                        image: { Image(uiImage: $0).resizable() }
                    )
                    .frame(width: 131, height: 183)
                    .aspectRatio(contentMode: .fit)

                    Spacer()

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Season 4")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .fontWeight(.bold)

                        Text("Nov 10, 19")
                            .font(.system(size: 10))
                            .foregroundColor(Color(#colorLiteral(red: 0.1378434002, green: 0.8040757179, blue: 0.3944021463, alpha: 1)))
                            .fontWeight(.semibold)

                        Button("View All Seasons") {
                            print("View All Seasons")
                        }
                        .padding()
                        .frame(height: 30)
                        .font(.system(size: 10, weight: .regular))
                        .background(Color(#colorLiteral(red: 0.1378434002, green: 0.8040757179, blue: 0.3944021463, alpha: 1)))
                        .foregroundColor(.white)
                        .cornerRadius(5)
                    }
                }

                Spacer()

                // TODO: hide if no casts
                HStack {
                    Text("Cast")
                        .font(.system(size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.1378434002, green: 0.8040757179, blue: 0.3944021463, alpha: 1)))
                        .fontWeight(.bold)
                    Spacer()
                }
            }
            .padding(EdgeInsets(top: 20, leading: 24, bottom: 0, trailing: 24))

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
                                image: { Image(uiImage: $0).resizable() }
                            )
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fit)
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

            Spacer()
        }
        .background(Color(#colorLiteral(red: 0.1437062621, green: 0.1527246833, blue: 0.1829863489, alpha: 1)))
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

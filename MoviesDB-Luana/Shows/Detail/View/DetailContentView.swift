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
                Text("Created by...")
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
                    url: viewModel.url,
                    placeholder: {
                        Text("Loading ...")
                            .fixedSize()
                    },
                    image: { Image(uiImage: $0).resizable() }
                )
                .aspectRatio(131/181, contentMode: .fit)

                VStack {
                    Text("Created by...")
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
                    .buttonStyle(LoginButtonStyle())
                }
            }

            HStack {
                Text("Cast")
                    .font(.system(size: 18))
                    .foregroundColor(Color(#colorLiteral(red: 0.1378434002, green: 0.8040757179, blue: 0.3944021463, alpha: 1)))
                    .fontWeight(.bold)
                Spacer()
            }

            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(0...10, id: \.self) { index in
                        VStack {
                            AsyncImage(
                                url: viewModel.url,
                                placeholder: {
                                    Text("Loading ...")
                                        .fixedSize()
                                },
                                image: { Image(uiImage: $0).resizable() }
                            )
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())

                            Text("actor name")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                        }
                    }
                }
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(#colorLiteral(red: 0.1437062621, green: 0.1527246833, blue: 0.1829863489, alpha: 1)))
        .cornerRadius(15)
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

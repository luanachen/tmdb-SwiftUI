//
//  ShowCell.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 31/03/21.
//

import Combine
import SwiftUI

struct ShowCell: View {
    @StateObject var viewModel: ShowCellViewModel

    var body: some View {
        let detailViewModel = ShowDetailViewModel(show: viewModel.show)

        NavigationLink(destination: ShowDetailView(viewModel: detailViewModel)) {
            VStack(spacing: 11) {
                AsyncImage(
                    url: viewModel.url,
                    placeholder: {
                        Text("Loading ...")
                            .fixedSize()
                    },
                    image: { Image(uiImage: $0).resizable() }
                )
                .aspectRatio(0.7, contentMode: .fit)

                HStack {
                    Text(viewModel.show.name)
                        .foregroundColor(Color(#colorLiteral(red: 0.1378434002, green: 0.8040757179, blue: 0.3944021463, alpha: 1)))
                        .font(.system(size: 13, weight: .bold))
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))

                HStack {
                    Text(viewModel.show.firstAirDate)
                    Spacer()
                    Text("★ \(String(viewModel.show.voteAverage))")
                }
                .font(.system(size: 10, weight: .semibold))
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                .foregroundColor(Color(#colorLiteral(red: 0.1378434002, green: 0.8040757179, blue: 0.3944021463, alpha: 1)))
                Text(viewModel.show.overview)
                    .foregroundColor(.white)
                    .font(.system(size: 10))
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8))
                    .frame(maxHeight: 56)
                Spacer()
            }
            .background(Color(#colorLiteral(red: 0.1024496332, green: 0.1580232382, blue: 0.1789078116, alpha: 1)))
            .cornerRadius(15)
        }
    }
}

struct ShowCell_Previews: PreviewProvider {
    static var previews: some View {
        let show = Show(name: "Movie name",
                        popularity: 7.5,
                        id: 1,
                        voteAverage: 8.9,
                        overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex.",
                        firstAirDate: "Aug 10, 2018", posterPath: "moviedb")
        let viewModel = ShowCellViewModel(show: show)
        ShowCell(viewModel: viewModel)
            .previewLayout(.fixed(width: 175, height: 350))
    }
}

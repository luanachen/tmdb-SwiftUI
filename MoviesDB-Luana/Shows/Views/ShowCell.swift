//
//  ShowCell.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 31/03/21.
//

import SwiftUI

struct ShowCell: View {
    var viewModel: ShowCellViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 11) {
            HStack {
                Spacer()
                Image(viewModel.show.posterPath)
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
            Text(viewModel.show.name)
                .foregroundColor(Color(#colorLiteral(red: 0.1378434002, green: 0.8040757179, blue: 0.3944021463, alpha: 1)))
                .font(.system(size: 13, weight: .bold))
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
            Spacer()
        }
        .background(Color(#colorLiteral(red: 0.1024496332, green: 0.1580232382, blue: 0.1789078116, alpha: 1)))
        .cornerRadius(15)
    }
}

struct ShowCell_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ShowCellViewModel()
        ShowCell(viewModel: viewModel)
            .previewLayout(.fixed(width: 175, height: 350))
    }
}

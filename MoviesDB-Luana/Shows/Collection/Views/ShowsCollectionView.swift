//
//  ShowsCollectionView.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 31/03/21.
//

import SwiftUI

struct ShowsCollectionView: View {

    @StateObject var viewModel = ShowsCollectionViewModel()

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    init() {
        setupSegmentedControl()
    }

    var body: some View {
        NavigationView {
            VStack {
                Picker("shows", selection: $viewModel.selectedShowType) {
                    ForEach(ShowTypes.allCases, id: \.self) {
                        Text($0.rawValue)
                            .font(.system(size: 13))
                    }
                }
                .onChange(of: viewModel.selectedShowType, perform: { value in
                    viewModel.fetchShowsForShow(type: value)

                })
                .pickerStyle(SegmentedPickerStyle())
                .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(viewModel.shows, id: \.id) { item in
                            let viewModel = ShowCellViewModel(show: item)
                            ShowCell(viewModel: viewModel)
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            }
            .background(Color.init("tmdb-backgroundColor"))
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("TV Shows")
            .navigationBarItems(
                trailing:
                    Button(action: {}, label: {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.white)
                    })
            )
            .preferredColorScheme(.dark)
        }
        .onAppear(perform: {
            viewModel.fetchShowsForShow(type: .popular)
        })
        .alert(isPresented: $viewModel.isShowingAlert) {
            Alert(title: Text("Loading error."),
                  dismissButton: .default(Text("Try again"), action: {
                    viewModel.fetchShowsForShow(type: .popular)
                  }))
        }
    }

    fileprivate func setupSegmentedControl() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.init(named: "tmdb-light-grey")
        UISegmentedControl.appearance().backgroundColor = UIColor.init(named: "tmdb-grey")
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
}

struct ShowsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ShowsCollectionView()
        }
    }
}

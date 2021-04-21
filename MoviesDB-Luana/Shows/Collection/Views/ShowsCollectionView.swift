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

    init(viewModel: ShowsCollectionViewModel = ShowsCollectionViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
        setupSegmentedControl()
        UINavigationBar.appearance().tintColor = .white
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
                    viewModel.onChangePickerView(value: value)
                })
                .pickerStyle(SegmentedPickerStyle())
                .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(viewModel.cellViewModels, id: \.id) { cellViewModel in
                            ShowCell(viewModel: cellViewModel)
                        }

                        if !viewModel.hasCompletedPagination {
                            ProgressView()
                                .onAppear {
                                    viewModel.onAppearProgressView()
                                }
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            }
            .background(Color("tmdb-backgroundColor"))
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
            .modifier(NavigationBarModifier(backgroundColor: UIColor(named: "tmdb-grey")))
        }
        .onAppear(perform: {
            viewModel.fetchShows(for: .popular)
        })
        .alert(isPresented: $viewModel.isShowingAlert) {
            Alert(title: Text("Loading error."),
                  dismissButton: .default(Text("Try again"), action: {
                    viewModel.fetchShows(for: .popular)
                  }))
        }
    }

    fileprivate func setupSegmentedControl() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "tmdb-light-grey")
        UISegmentedControl.appearance().backgroundColor = UIColor(named: "tmdb-grey")
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
}

struct ShowsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ShowsCollectionViewModel(service: nil)

        for _ in 0...6 {
            let show = Show(name: "Movie name",
                            popularity: 7.5,
                            id: 1,
                            voteAverage: 8.9,
                            overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex.",
                            firstAirDate: "Aug 10, 2018", posterPath: "moviedb")
            let cellViewModel = ShowCellViewModel(show: show)
            viewModel.cellViewModels.append(cellViewModel)
        }

        let view = ShowsCollectionView(viewModel: viewModel)

        return view
    }
}

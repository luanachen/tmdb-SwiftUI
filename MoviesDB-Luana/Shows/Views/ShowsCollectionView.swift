//
//  ShowsCollectionView.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 31/03/21.
//

import SwiftUI

let data = (1...100).map { "Item \($0)" }

struct ShowsCollectionView: View {

    @State private var selectedShowType = "Popular"
    var showTypes = ["Popular", "Top Rated", "On TV", "Airing Today"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    let coloredNavAppearance = UINavigationBarAppearance()

    init() {
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = #colorLiteral(red: 0.1285548806, green: 0.1735598147, blue: 0.1902512908, alpha: 1)
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
        
        UISegmentedControl.appearance().selectedSegmentTintColor = #colorLiteral(red: 0.3883456886, green: 0.3880380392, blue: 0.4010984898, alpha: 1)
        UISegmentedControl.appearance().backgroundColor = #colorLiteral(red: 0.09150201827, green: 0.1260478795, blue: 0.151537925, alpha: 1)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("shows", selection: $selectedShowType) {
                    ForEach(showTypes, id: \.self) {
                        Text($0)
                            .font(.system(size: 13))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(data, id: \.self) { item in
                            let viewModel = ShowCellViewModel()
                            ShowCell(viewModel: viewModel)
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            }
            .background(Color(#colorLiteral(red: 0.03721841797, green: 0.08316937834, blue: 0.1041800603, alpha: 1)))
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
        }
    }
}

struct ShowsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ShowsCollectionView()
        }
    }
}

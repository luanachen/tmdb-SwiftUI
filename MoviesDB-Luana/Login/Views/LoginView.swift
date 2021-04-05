//
//  ContentView.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 30/03/21.
//

import Combine
import SwiftUI

struct LoginView: View {
    @Environment(\.openURL) var openURL

    @ObservedObject var viewModel = LoginViewModel()

    @State var pushActive = false

    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.0320315659, green: 0.08327228576, blue: 0.1042201295, alpha: 1)).edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Image("moviedb")
                    .resizable()
                    .frame(width: 114, height: 128)
                    .padding(.bottom, 82)
                TextField("Username", text: $viewModel.username)
                    .modifier(LoginTextFieldModifier())
                SecureField("Password", text: $viewModel.password)
                    .modifier(LoginTextFieldModifier())
                Button("Log in") {
                    viewModel.login {
                        pushActive.toggle()
                    }
                }
                .buttonStyle( LoginButtonStyle())
                .disabled(!viewModel.isValid)
                .opacity(viewModel.isValid ? 1 : 0.5)
                .fullScreenCover(isPresented: $pushActive, content: {
                    ShowsCollectionView()
                })
            }
            .padding(EdgeInsets(top: 0, leading: 80, bottom: 0, trailing: 80))
        }
        .onAppear(perform: {
            viewModel.fetchRequestToken {
                if let token = viewModel.requestToken, let url = URL(string: "https://www.themoviedb.org/authenticate/\(token)?redirect_to=MoviesDB-Luana://") {
                    openURL(url)
                }
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


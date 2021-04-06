//
//  ContentView.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 30/03/21.
//

import Combine
import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()

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
                    viewModel.login()
                }
                .buttonStyle( LoginButtonStyle())
                .disabled(!viewModel.isValid)
                .opacity(viewModel.isValid ? 1 : 0.5)
                .fullScreenCover(isPresented: $viewModel.pushActive, content: {
                    ShowsCollectionView()
                })
            }
            .padding(EdgeInsets(top: 0, leading: 80, bottom: 0, trailing: 80))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


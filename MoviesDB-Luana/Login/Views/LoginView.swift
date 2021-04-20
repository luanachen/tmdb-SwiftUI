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
            Color("tmdb-backgroundColor").edgesIgnoringSafeArea(.all)
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
                .fullScreenCover(isPresented: $viewModel.pushActive, content: {
                    ShowsCollectionView()
                })
            }
            .padding(EdgeInsets(top: 0, leading: 80, bottom: 0, trailing: 80))
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Login Error."),
                  message: Text("Please try again."),
                  dismissButton: .default(Text("Ok")))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


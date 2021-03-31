//
//  ContentView.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 30/03/21.
//

import SwiftUI

struct LoginView: View {

    @ObservedObject var viewModel = LoginViewModel()

    var body: some View {
        Color(#colorLiteral(red: 0.03721841797, green: 0.08316937834, blue: 0.1041800603, alpha: 1)).overlay(
            VStack(spacing: 20) {
                Image("moviedb")
                    .resizable()
                    .frame(width: 114, height: 128)
                    .padding(.bottom, 82)
                TextField("Username", text: $viewModel.username)
                    .modifier(LoginTextFieldModifier())
                SecureField("Password", text: $viewModel.password)
                    .modifier(LoginTextFieldModifier())
                Button(action: {
                    viewModel.login()
                }) {
                    LoginButtonContent()
                }
                .disabled(!viewModel.isValid)
                .opacity(viewModel.isValid ? 1 : 0.5)
            }
            .padding(EdgeInsets(top: 0, leading: 80, bottom: 0, trailing: 80))
        )
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


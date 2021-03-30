//
//  ContentView.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 30/03/21.
//

import SwiftUI

struct LoginView: View {

    @State var username: String = ""
    @State var password: String = ""

    var body: some View {
        Color(#colorLiteral(red: 0.03721841797, green: 0.08316937834, blue: 0.1041800603, alpha: 1)).overlay(
            VStack(spacing: 20) {
                Image("moviedb")
                    .resizable()
                    .frame(width: 114, height: 128)
                    .padding(.bottom, 82)
                TextField("Username", text: $username)
                    .modifier(LoginTextFieldModifier())
                SecureField("Password", text: $password)
                    .modifier(LoginTextFieldModifier())
                Button(action: {print("Button tapped")}) {
                    LoginButtonContent()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 80, bottom: 0, trailing: 80))
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


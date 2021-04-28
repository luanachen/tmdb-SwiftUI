//
//  LoginButton.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 30/03/21.
//
// Reference: https://swiftui-lab.com/custom-styling/
// get the enabled state from the environment by creating a wrapper view and using it inside the style struct

import SwiftUI

struct LoginButtonStyle: ButtonStyle {

    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        LoginButton(configuration: configuration)
    }

    struct LoginButton: View {
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool

        var body: some View {
            configuration.label
                .padding()
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .background(Color(UIColor.tmdb_green))
                .opacity(isEnabled ? 1 : 0.5)
                .cornerRadius(5)
        }
    }
}

struct LoginButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Press Me") {
            print("Button pressed!")
        }
        .buttonStyle(LoginButtonStyle())
    }
}

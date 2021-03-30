//
//  LoginButton.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 30/03/21.
//

import SwiftUI

struct LoginButtonContent: View {
    var body: some View {
        return Text("LOG IN")
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .padding()
            .background(Color(#colorLiteral(red: 0.1378434002, green: 0.8040757179, blue: 0.3944021463, alpha: 1)))
            .cornerRadius(5)
    }
}

struct LoginButton_Previews: PreviewProvider {
    static var previews: some View {
        LoginButtonContent()
            .padding()
    }
}

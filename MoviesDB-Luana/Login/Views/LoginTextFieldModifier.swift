//
//  LoginTextFieldModifier.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 30/03/21.
//

import SwiftUI

struct LoginTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding()
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(5)
    }
}

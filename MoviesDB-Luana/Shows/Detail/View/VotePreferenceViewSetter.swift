//
//  VoteViewPreferenceKey.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 08/04/21.
//
// Reference: https://swiftui-lab.com/communicating-with-the-view-tree-part-1/

import SwiftUI

struct VotePreferenceViewSetter: View {
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(key: VoteViewPreferenceKey.self,
                            value: [VoteViewPreferenceData(rect: geometry.frame(in: .named("Zstack")))])
        }
    }
}

struct VoteViewPreferenceKey: PreferenceKey {
    typealias Value = [VoteViewPreferenceData]

    static var defaultValue: [VoteViewPreferenceData] = []

    static func reduce(value: inout [VoteViewPreferenceData], nextValue: () -> [VoteViewPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

struct VoteViewPreferenceData: Equatable {
    let rect: CGRect
}



//
//  ShowsCoordinator.swift
//  MoviesDB-Luana
//
//  Created by Luana on 04/05/21.
//

import SwiftUI

public protocol ShowsCoordinatorDelegate: AnyObject {
    func startNextFlow() -> AnyView
}

public class ShowsCoordinator {
    
    weak var delegate: ShowsCoordinatorDelegate?
    
    public init(delegate: ShowsCoordinatorDelegate?) {
        self.delegate = delegate
    }
    
    public func start() -> AnyView {
        AnyView(ShowsCollectionView())
    }
    
}

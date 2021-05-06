//
//  File.swift
//  
//
//  Created by Luana on 03/05/21.
//

import SwiftUI

public protocol LoginCoordinatorDelegate: AnyObject {
    func startNextFlow() -> AnyView
}

public class LoginCoordinator {
    
    weak var delegate: LoginCoordinatorDelegate?
    
    public init(delegate: LoginCoordinatorDelegate?) {
        self.delegate = delegate
    }
    
    public func start() -> AnyView {
        AnyView(LoginView(delegate: delegate))
    }
    
}

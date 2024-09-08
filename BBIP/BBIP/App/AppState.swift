//
//  AppState.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import Foundation
import SwiftUI

enum AppState {
    case onboarding
    case infoSetup
    case home
}

final class AppStateManager: ObservableObject {
    @Published var state: AppState
    @Published var path = NavigationPath()
    
    func goUIS() {
        self.state = .infoSetup
    }
    
    func goHome() {
        self.state = .home
    }
    
    init() {
        let isLoggedIn = UserDefaultsManager.shared.checkLoginStatus()
        self.state = isLoggedIn ? .home : .onboarding
    }
}

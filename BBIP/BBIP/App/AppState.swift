//
//  AppState.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import Foundation
import SwiftUI

enum AppState: String {
    case onboarding
    case infoSetup
    case startGuide
    case home
}

enum MainHomeViewDestination: Hashable {
    case notice
    case mypage
    
    // MARK: - UserHome
    case startSIS       // sis startPoint
    case SIS            // study into setup
    case completeSIS    // sis endPoing
    
    // MARK: - StudyHome
    case setLocation(prevLocation:String, studyId: String, session: Int)
}

final class AppStateManager: ObservableObject {
    @Published var state: AppState
    @Published var path = NavigationPath()
    @Published var colorScheme: ColorScheme = .light
    
    // DeepLink
    @Published var showDeepLinkAlert: Bool = false
    @Published var showJoinFailAlert: Bool = false
    @Published var deepLinkAlertData: DeepLinkAlertData?
    
    func setDeepLinkAlertData(_ data: DeepLinkAlertData) {
        self.deepLinkAlertData = data
    }
    
    func setDarkMode() {
        self.colorScheme = .dark
    }
    
    func setLightMode() {
        self.colorScheme = .light
    }
    
    func popToRoot() {
        setLightMode()
        path = .init()
    }
    
    func switchRoot(_ state: AppState) {
        withAnimation { self.state = state }
        print("Switch Root to \(state.rawValue)")
    }
    
    func push(_ at: MainHomeViewDestination) {
        self.path.append(at)
    }
    
    init() {
        let isLoggedIn = UserDefaultsManager.shared.checkLoginStatus()
        self.state = isLoggedIn ? .home : .onboarding
    }
}

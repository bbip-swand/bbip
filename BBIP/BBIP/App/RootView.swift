//
//  ContentView.swift
//  BBIP
//
//  Created by 이건우 on 7/30/24.
//

import SwiftUI

struct RootView: View {
    @StateObject private var appStateManager = AppStateManager(state: .onboarding)
    // isLoggedIn: UserDefaultsManager.shared.checkLoginStatus()
    
    var body: some View {
        Group {
            switch appStateManager.state {
            case .onboarding:
                NavigationStack {
                    OnboardingView()
                }
                
            case .infoSetup:
                NavigationStack {
                    UserInfoSetupView()
                }
                
            case .home:
                NavigationStack {
                    HomeView()
                }
            }
        }
        .environmentObject(appStateManager)
    }
}

#Preview {
    RootView()
}

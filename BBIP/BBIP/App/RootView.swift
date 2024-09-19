//
//  ContentView.swift
//  BBIP
//
//  Created by 이건우 on 7/30/24.
//

import SwiftUI

struct RootView: View {
    @StateObject private var appStateManager = AppStateManager()
    
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
                NavigationStack(path: $appStateManager.path) {
                    MainHomeView()
                }
            }
        }
        .preferredColorScheme(appStateManager.colorScheme)
        .environmentObject(appStateManager)
    }
}

#Preview {
    RootView()
}

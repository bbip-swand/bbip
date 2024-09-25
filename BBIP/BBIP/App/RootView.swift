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
        .onOpenURL { url in
            handleDeepLink(url)
        }
    }
    
    private func handleDeepLink(_ url: URL) {
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if urlComponents?.host == "inviteStudy" {
            if let queryItems = urlComponents?.queryItems {
                let data = queryItems.first(where: { $0.name == "data" })?.value
                // handle data
                appStateManager.showDeepLinkAlert = true
            }
        }
    }
}

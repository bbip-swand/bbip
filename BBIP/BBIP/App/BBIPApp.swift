//
//  BBIPApp.swift
//  BBIP
//
//  Created by 이건우 on 7/30/24.
//

import SwiftUI

@main
struct BBIPApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var showSplash = true
    @State private var isNewUser = false
    
    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView(showSplash: $showSplash)
            } else {
                RootView()
                    .onAppear {
                        print(UserDefaultsManager.shared.getAccessToken())
                    }
            }
        }
    }
}

struct SplashView: View {
    @Binding var showSplash: Bool
    private let userStateManager = UserStateManager()
    
    var body: some View {
        Text("splash")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    userStateManager.updateIsExistingUser {
                        withAnimation { showSplash = false }
                    }
                }
            }
    }
}

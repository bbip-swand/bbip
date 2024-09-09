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
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .onAppear {
                    print(UserDefaultsManager.shared.getAccessToken())
                }
//            NavigationStack {
//                NavigationLink {
//                    StartCreateStudyView()
//                } label: {
//                    Text("Go to Create Study")
//                        .font(.bbip(.title4_sb24))
//                }
//            }
        }
    }
}

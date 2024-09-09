//
//  HomeView.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import SwiftUI

struct MainHomeView: View {
    @State private var selectedTab: Tab = .UserHome
    @State private var showNoticeView: Bool = false
    @State private var showMypageView: Bool = false
    
    // TODO: Use NoticeManager...
    @State private var hasNotice: Bool = false
    
    var body: some View {
        VStack {
            BBIPHearderView(
                showDot: $hasNotice,
                onNoticeTapped: { showNoticeView = true },
                onProfileTapped: { showMypageView = true }
            )
            
            Spacer()
            
            BBIPTabView(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationDestination(isPresented: $showNoticeView) {
            NoticeView()
        }
        .navigationDestination(isPresented: $showMypageView) {
            MypageView()
        }
    }
}

#Preview {
    MainHomeView()
}

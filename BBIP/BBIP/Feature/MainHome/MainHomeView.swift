//
//  HomeView.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import SwiftUI

struct MainHomeView: View {
    @State private var selectedTab: MainHomeTab = .userHome
    @State private var showNoticeView: Bool = false
    @State private var showMypageView: Bool = false
    
    // TODO: Use NoticeManager...
    @State private var hasNotice: Bool = false
    
    @ObservedObject private var viewModel = MainHomeViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                switch selectedTab {
                case .userHome:
                    BBIPHearderView(
                        showDot: $hasNotice,
                        onNoticeTapped: { showNoticeView = true },
                        onProfileTapped: { showMypageView = true }
                    )
                    UserHomeView(viewModel: viewModel)
                case .calendar:
                    CalendarView()
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)

            BBIPTabView(selectedTab: $selectedTab)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .edgesIgnoringSafeArea(.bottom)
        }
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

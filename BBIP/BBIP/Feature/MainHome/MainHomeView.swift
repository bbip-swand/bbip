//
//  HomeView.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import SwiftUI

struct MainHomeView: View {
    @ObservedObject private var viewModel = MainHomeViewModel()
    @State private var selectedTab: MainHomeTab = .userHome
    
    // MARK: - Navigation Destination
    @State private var showNoticeView: Bool = false
    @State private var showMypageView: Bool = false
    @State private var showCreateStudyView: Bool = false
    
    // TODO: Use NoticeManager...
    @State private var hasNotice: Bool = false
    
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

            BBIPTabView(selectedTab: $selectedTab, showCreateStudyView: $showCreateStudyView)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .edgesIgnoringSafeArea(.bottom)
        }
        .navigationDestination(isPresented: $showNoticeView) {
            NoticeView()
        }
        .navigationDestination(isPresented: $showMypageView) {
            MypageView()
        }
        .navigationDestination(isPresented: $showCreateStudyView) {
            StartCreateStudyView()
        }
    }
}

#Preview {
    MainHomeView()
}

//
//  HomeView.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import SwiftUI

struct MainHomeView: View {
    @EnvironmentObject var appState: AppStateManager
    @ObservedObject private var viewModel = MainHomeViewModel()
    @State private var selectedTab: MainHomeTab = .userHome
    
    // MARK: - Navigation Destination
    @State private var hasNotice: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                switch selectedTab {
                case .userHome:
                    BBIPHearderView(
                        showDot: $hasNotice,
                        onNoticeTapped: {
                            appState.path.append("NoticeView")
                        },
                        onProfileTapped: {
                            appState.path.append("MypageView")
                        }
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
        .onAppear {
            appState.setLightMode()
        }
        .navigationDestination(for: MainHomeViewDestination.self) { destination in
            switch destination {
            case .notice:
                NoticeView()
            case .mypage:
                MypageView()
            case .startSIS:
                StartCreateStudyView()
            default:
                EmptyView()
            }
        }
    }
}


#Preview {
    MainHomeView()
}

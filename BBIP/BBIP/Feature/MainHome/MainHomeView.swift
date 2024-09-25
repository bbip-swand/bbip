//
//  HomeView.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import SwiftUI

struct MainHomeView: View {
    @EnvironmentObject var appState: AppStateManager
    @StateObject private var viewModel = DIContainer.shared.makeMainHomeViewModel()
    @State private var selectedTab: MainHomeTab = .userHome
    @State private var hasLoaded: Bool = false
    
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
                            appState.push(.notice)
                        },
                        onProfileTapped: {
                            appState.push(.mypage)
                        }
                    )
                    UserHomeView(viewModel: viewModel)
                case .studyHome:
                    StudyHomeView()
                case .calendar:
                    CalendarView()
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            BBIPTabView(
                selectedTab: $selectedTab,
                ongoingStudyData: $viewModel.ongoingStudyData
            )
            .frame(maxHeight: .infinity, alignment: .bottom)
            .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear {
            appState.setLightMode()
            if !hasLoaded {
                print("mainHome OnAppear")
                viewModel.loadHomeData()
                hasLoaded = true
            }
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
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    MainHomeView()
}

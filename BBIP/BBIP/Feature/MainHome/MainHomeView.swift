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
    
    private func studyNameForHeader() -> String {
        if case .studyHome(_, let studyName) = selectedTab {
            return studyName
        }
        return .init()
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                switch selectedTab {
                case .userHome:
                    UserHomeHeaderView(
                        showDot: $hasNotice,
                        tabState: selectedTab
                    )
                    UserHomeView(viewModel: viewModel)
                case .studyHome(let studyId, _):
                    StudyHomeView(studyId: studyId)
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
            print("mainHome OnAppear")
            appState.setLightMode()
            viewModel.loadHomeData()
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

//
//  HomeView.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import SwiftUI

struct MainHomeView: View {
    @State private var selectedTab: Tab = .UserHome
    @State private var navigationBarColor: Color = .mainWhite // 기본 네비게이션 바 배경색
    @State private var rightIconName: String? // 툴바 오른쪽 끝에 아이콘 추가
    
    // 뷰 전환을 위한 상태
    @State private var showNoticeView: Bool = false
    @State private var showMypageView: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                // 메인 화면의 콘텐츠
                switch selectedTab {
                case .UserHome:
                    Text("You are in UserHomepage.")
                case .CreateSwitchStudy:
                    Text("You can create and switch study.")
                case .Calendar:
                    Text("You are in Calendar page.")
                }

                VStack {
                    // CustomHeaderView에서 아이콘 클릭 시 상태 변경
                    CustomHeaderView(showDot: false, onNoticeTapped: {
                        showNoticeView = true
                    }, onProfileTapped: {
                        showMypageView = true
                    })

                    Spacer()

                    CustomTabBarView(selectedTab: $selectedTab)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            
            .animation(.easeInOut, value: showNoticeView || showMypageView)
            .navigationDestination(isPresented: $showNoticeView) {
                // Notice View 전환
                Text("This is the Notice Page.")
                    .padding()
                    .navigationTitle(Text("알림").font(.bbip(.button1_m20)))
                    .backButtonStyle(isReversal: false) 
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                
                            } label: {
                                Image("setting_icon")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    
                            }
                        }
                    }
 
            }
            .navigationDestination(isPresented: $showMypageView) {
                // Mypage View 전환
                Text("This is the Mypage.")
                    .padding()
                    .navigationTitle(Text("마이페이지").font(.bbip(.button1_m20)))
                    .backButtonStyle(isReversal: false)

            }
        }
        
    }
}



#Preview {
    MainHomeView()
}

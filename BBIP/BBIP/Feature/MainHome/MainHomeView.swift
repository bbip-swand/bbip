//
//  HomeView.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import SwiftUI
import UIKit


extension View {
    // 네비게이션 바 색상을 설정
    func setNavigationBarColor(color: Color) {
        let uiColor = UIColor(color)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = uiColor
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    // 네비게이션 바 색상을 초기화
    func resetNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

struct MainHomeView: View {
    @State private var selectedTab: Tab = .UserHome
    @State private var rightIconName: String? // 툴바 오른쪽 끝에 아이콘 추가
    
    // 뷰 전환을 위한 상태
    @State private var showNoticeView: Bool = false
    @State private var showMypageView: Bool = false
    
    var body: some View {
        NavigationStack {
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
                    .onAppear {
                        self.setNavigationBarColor(color: .mainWhite)
                        self.resetNavigationBar()
                    }
                    
                    
            }
            .navigationDestination(isPresented: $showMypageView) {
                // Mypage View 전환
                Text("This is the Mypage.")
                    .padding()
                    .navigationTitle(Text("마이페이지").font(.bbip(.button1_m20)))
                    .backButtonStyle(isReversal: false)
                    .onAppear {
                        self.setNavigationBarColor(color: .gray1)
                        self.resetNavigationBar()
                    }
                    
                    
            }
        }
    }
}

#Preview {
    MainHomeView()
}

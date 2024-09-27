//
//  StudyHomeView.swift
//  BBIP
//
//  Created by 이건우 on 9/24/24.
//

import SwiftUI

struct StudyHomeView: View {
    private let studyId: String
    
    init(studyId: String) {
        self.studyId = studyId
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                headerView
                    .zIndex(1)
                
                ZStack {
                    Color.gray1
                    
                }
                .frame(height: 1020)
                
                Spacer()
                    .frame(minHeight: 150)
            }
        }
        .background(VStack{Color.gray9.frame(height: 300); Color.gray1})
        .frame(maxHeight: .infinity)
        .refreshable {
            // refresh
        }
        .scrollIndicators(.never)
        .introspect(.scrollView, on: .iOS(.v17, .v18)) { scrollView in
            scrollView.refreshControl?.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            scrollView.refreshControl?.tintColor = .primary3
        }
    }
    
    var headerView: some View {
        ZStack() {
            Color.gray9
                .frame(height: 320)
                .overlay(alignment: .bottomTrailing) {
                    Image("boxing_ring")
                        .offset(y: 37)
                        .zIndex(1)
                }
            VStack(spacing: 0) {
                NoticeBannerView(pendingNotice: "다음주 스터디 하루 쉬어갑니다! 확인 해주세요...!", isDark: true)
                    .padding(.top, 22)
                    .padding(.bottom, 28)
                
                HStack(spacing: 10) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 30, height: 24)
                        .foregroundStyle(.primary3)
                        .overlay {
                            Text("8R")
                                .font(.bbip(.caption2_m12))
                        }
                    
                    Text("2차 과제 제출 확인 및 피드백우뱌뱌뱌바바바")
                        .font(.bbip(.body2_m14))
                        .frame(maxWidth: UIScreen.main.bounds.width - 160, maxHeight: 20)
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 14)
                .foregroundStyle(.mainWhite)
                
                HStack(spacing: 10) {
                    Image("study_calendar")
                        .renderingMode(.template)
                        .foregroundColor(.gray6)
                    
                    Text("8월 14일 / 12:00 ~ 18:00")
                        .font(.bbip(.caption2_m12))
                        .foregroundStyle(.gray2)
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                
                Spacer()
            }
            .frame(maxHeight: 320)
        }
    }
}

#Preview {
    StudyHomeView(studyId: "a")
}

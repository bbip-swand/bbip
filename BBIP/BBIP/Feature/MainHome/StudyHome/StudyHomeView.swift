//
//  StudyHomeView.swift
//  BBIP
//
//  Created by 이건우 on 9/24/24.
//

import SwiftUI
import Combine


struct StudyHomeView: View {
    @StateObject private var viewModel: StudyHomeViewModel = DIContainer.shared.makeStudyHomeViewModel()
    private let studyId: String
    
    init(studyId: String) {
        self.studyId = studyId
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                headerView
                    .zIndex(1)
                
                StudyHomeInnerView {
                    coreFeatureButtons
                        .padding(.top, 50)
                        .padding(.bottom, 27)
//                    
                    
                    studyProgress
                        .padding(.bottom, 32)
                    
                    weeklyContent
                   
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
        .onAppear {
            print(studyId)
            viewModel.requestFullStudyInfo(studyId: studyId)
        }
        .onChange(of: studyId) { _, newVal in
            viewModel.requestFullStudyInfo(studyId: newVal)
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
                            if let currentWeek = viewModel.fullStudyInfo?.currentWeek {
                                Text(currentWeek.description + "R")
                                    .font(.bbip(.caption2_m12))
                            }
                        }
                    
                    if let currentContent = viewModel.fullStudyInfo?.currentWeekContent {
                        Text(currentContent)
                            .font(.bbip(.body2_m14))
                            .frame(maxWidth: UIScreen.main.bounds.width - 160, maxHeight: 20, alignment: .leading)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 14)
                .foregroundStyle(.mainWhite)
                
                HStack(spacing: 10) {
                    Image("study_calendar")
                        .renderingMode(.template)
                        .foregroundColor(.gray6)
                    
                    if let dateStr = viewModel.fullStudyInfo?.pendingDateStr {
                        Text(dateStr + " / " + viewModel.fullStudyInfo!.pendingDateTimeStr)
                            .font(.bbip(.caption2_m12))
                            .foregroundStyle(.gray2)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                
                Spacer()
            }
            .frame(maxHeight: 320)
        }
    }
    
    var coreFeatureButtons: some View {
        HStack {
            VStack(spacing: 12) {
                Button {
                    // go attendance
                } label: {
                    Image("studyHome_attendance")
                }
                
                Text("출석 인증")
            }
            
            Spacer()
            
            VStack(spacing: 12) {
                Button {
                    // go location
                } label: {
                    Image("studyHome_location")
                }
                
                Text("장소 확인")
            }
            
            Spacer()
            
            VStack(spacing: 12) {
                Button {
                    // go archive
                } label: {
                    Image("studyHome_archive")
                }
                
                Text("아카이브")
            }
        }
        .font(.bbip(.button2_m16))
        .padding(.horizontal, 33)
    }
    
    var studyProgress: some View {
        VStack(spacing: 12) {
            HStack {
                Text("스터디 진척도")
                    .font(.bbip(.body1_b16))
                    .padding(.leading, 11)
                
                Spacer()
            }
            
            if let totalWeek = viewModel.fullStudyInfo?.totalWeeks {
                StudyProgressBar(
                    totalWeek: totalWeek,
                    currentWeek: viewModel.fullStudyInfo!.currentWeek,
                    periodString: viewModel.fullStudyInfo!.studyPeriodString
                )
            } else {
                StudyProgressBar(
                    totalWeek: 50,
                    currentWeek: 1,
                    periodString: "placeholderplaceholder"
                )
                .redacted(reason: .placeholder)
            }
        }
        .animation(.easeInOut, value: viewModel.fullStudyInfo?.totalWeeks)
    }
    
    var weeklyContent: some View {
        VStack(spacing: 12) {
            HStack {
                Text("주차별 활동")
                    .font(.bbip(.body1_b16))
                    .padding(.leading, 11)
                
                Spacer()
            }
            
            if let contents = viewModel.fullStudyInfo?.studyContents {
                let currentWeek = viewModel.fullStudyInfo?.currentWeek ?? 0
                let maxWeeks = min(3, contents.count - currentWeek)
                
                ForEach(0..<maxWeeks, id: \.self) { index in
                    let weekIndex = currentWeek + index
                    let content = contents[weekIndex].isEmpty ? "미정" : contents[weekIndex]
                    WeeklyStudyContentCell(weekVal: weekIndex, content: content)
                }
            } else {
                // You can handle the empty state here
                Text("No contents available")
            }
        }
        .animation(.easeInOut, value: viewModel.fullStudyInfo?.studyContents)
    }

}

struct StudyHomeInnerView<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        ZStack(alignment: .top) {
            Color.gray1
            
            VStack {
                content
            }
            .padding(.horizontal, 17)
        }
    }
}

#Preview {
    StudyHomeView(studyId: "a")
}

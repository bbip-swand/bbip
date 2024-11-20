//
//  WeeklyStudyContentListView.swift
//  BBIP
//
//  Created by 이건우 on 11/20/24.
//

import SwiftUI

/// 주차별 활동 전체보기 뷰 (스터디 홈)
struct WeeklyStudyContentListView: View {
    private let weeklyStudyContent: [String]
    
    init(weeklyStudyContent: [String]) {
        self.weeklyStudyContent = weeklyStudyContent
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(0..<weeklyStudyContent.count, id: \.self) { index in
                    WeeklyStudyContentCardView(week: index + 1, content: weeklyStudyContent[index])
                }
            }
            .padding(.vertical, 22)
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.gray1)
        .navigationTitle("주차별 활동")
        .navigationBarTitleDisplayMode(.inline)
        .backButtonStyle()
        .onAppear {
            setNavigationBarAppearance(backgroundColor: .gray1)
        }
    }
}

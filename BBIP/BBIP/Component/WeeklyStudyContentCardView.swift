//
//  WeeklyStudyContentCardView.swift
//  BBIP
//
//  Created by 이건우 on 11/20/24.
//

import SwiftUI

/// 주차별 활동 전체보기에서 쓰이는 CardView
/// 간단히 주차와 내용만 표시함.
struct WeeklyStudyContentCardView: View {
    private var week: Int
    private var content: String
    
    init(
        week: Int,
        content: String
    ) {
        self.week = week
        self.content = content
    }
    
    var contentText: String {
        content.isEmpty ? "입력된 주차 계획이 없어요" : content
    }
    var textColor: Color {
        content.isEmpty ? .gray5 : .gray8
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            CapsuleView(title: "\(week)주차", type: .fill)
            Text(contentText)
                .font(.bbip(.body2_m14))
                .foregroundStyle(textColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.mainWhite)
        )
        .padding(.horizontal, 17)
        .bbipShadow1()
    }
}

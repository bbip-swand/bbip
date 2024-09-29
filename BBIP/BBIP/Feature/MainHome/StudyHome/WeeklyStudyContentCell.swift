//
//  WeeklyStudyContentCell.swift
//  BBIP
//
//  Created by 이건우 on 9/28/24.
//

import SwiftUI

struct WeeklyStudyContentCell: View {
    private let weekVal: Int
    private let content: String?
    private let dateStr: String
    private let isCurrentWeek: Bool
    
    init(
        weekVal: Int,
        content: String,
        dateStr: String,
        isCurrentWeek: Bool
    ) {
        self.weekVal = weekVal
        self.content = content
        self.dateStr = dateStr
        self.isCurrentWeek = isCurrentWeek
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Circle()
                .foregroundStyle(isCurrentWeek ? .primary3 : .gray3)
                .frame(width: 36, height: 36)
                .overlay() {
                    Text(weekVal.description)
                        .font(.bbip(.body1_sb16))
                        .foregroundStyle(isCurrentWeek ? .mainWhite : .gray8)
                }
                .padding(.leading, 18)
                .fixedSize()
            
            VStack(alignment: .leading, spacing: 3) {
                if let content {
                    if content.isEmpty {
                        Text("아직 입력된 주차 계획이 없어요")
                            .font(.bbip(.body1_sb16))
                            .foregroundStyle(.gray5)
                    } else {
                        Text(content)
                            .font(.bbip(.body1_sb16))
                    }
                }
                
                Text(dateStr)
                    .font(.bbip(.caption2_m12))
                    .foregroundStyle(.gray6)
            }
            
            Spacer()
        }
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.mainWhite)
                .bbipShadow1()
        )
    }
}

#Preview {
    WeeklyStudyContentCell(
        weekVal: 1,
        content: "ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅁㄴ",
        dateStr: "aa",
        isCurrentWeek: false
    )
}

//
//  ScheduleCardView.swift
//  BBIP
//
//  Created by 이건우 on 11/12/24.
//

import SwiftUI

struct ScheduleCardView: View {
    private let schedule: ScheduleVO
    private let height: CGFloat = 64
    
    init(schedule: ScheduleVO) {
        self.schedule = schedule
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            VStack(alignment: .leading, spacing: 8) {
                Text(schedule.title)
                    .font(.bbip(.body2_m14))
                    .foregroundStyle(.mainBlack)
                    .lineLimit(1)
                Text(schedule.formattedDateRange)
                    .font(.bbip(.caption3_r12))
                    .foregroundStyle(.gray7)
                    .lineLimit(1)
            }
            
            Spacer()
            
            CapsuleView(title: schedule.studyName, type: .fill)
        }
        .frame(height: height)
        .padding(.leading, 13)
        .padding(.trailing, 10)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.mainWhite)
                .frame(height: height)
        }
    }
}


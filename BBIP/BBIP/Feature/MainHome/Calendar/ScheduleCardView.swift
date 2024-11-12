//
//  ScheduleCardView.swift
//  BBIP
//
//  Created by 이건우 on 11/12/24.
//

import SwiftUI

struct ScheduleCardView: View {
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                Text("접수 시작접수 시작접수 시작접수 ")
                    .font(.bbip(.body2_m14))
                    .foregroundStyle(.mainBlack)
                    .lineLimit(1)
                Text("aaa")
                    .font(.bbip(.caption3_r12))
                    .foregroundStyle(.gray7)
            }
            
            Spacer()
                .frame(width: 20)
            
            CapsuleView(title: "aa", type: .fill)
        }
        .padding(.leading, 13)
        .padding(.trailing, 10)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.mainWhite)
                .frame(minHeight: 64, maxHeight: 80)
                .bbipShadow1()
        }
    }
}

#Preview {
    ScheduleCardView()
}

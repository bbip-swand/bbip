//
//  UpcommingScheduleCardView.swift
//  BBIP
//
//  Created by 이건우 on 9/11/24.
//

import SwiftUI

struct UpcommingScheduleCardView: View {
    private let vo: UpcommingScheduleVO
    
    init(vo: UpcommingScheduleVO) {
        self.vo = vo
    }
    
    private var ddayText: String {
        vo.leftDay == 0
        ? "D-Day"
        : "D-\(vo.leftDay)"
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.mainWhite)
                .frame(width: 133, height: 146)
            
            VStack(spacing: 0) {
                Image("dday_icon\(vo.iconType)")
                    .resizable()
                    .frame(width: 53, height: 53)
                    .padding(.bottom, 12)
                
                Text(ddayText)
                    .font(.bbip(.body1_sb16))
                    .foregroundStyle(.mainBlack)
                    .padding(.bottom, 4)
                
                Text(vo.description)
                    .font(.bbip(.body2_m14))
                    .foregroundStyle(.gray7)
            }
        }
    }
}

struct UpcommingScheduleCardViewPlaceholder: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.gray2)
                .frame(width: 133, height: 146)
            
            VStack(spacing: 0) {
                Image("logo_placeholder")
                    .resizable()
                    .frame(width: 53, height: 53)
                    .padding(.bottom, 15)
                
                Text("추가된\n일정이 없어요")
                    .font(.bbip(.body1_sb16))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray6)
                    .padding(.bottom, 4)
            }
        }
    }
}

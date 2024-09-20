//
//  CommingScheduleCardView.swift
//  BBIP
//
//  Created by 이건우 on 9/11/24.
//

import SwiftUI

struct CommingScheduleCardView: View {
    private let vo: CommingScheduleVO
    
    init(vo: CommingScheduleVO) {
        self.vo = vo
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
                
                Text("D-\(vo.leftDay)")
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

#Preview {
    CommingScheduleCardView(vo: .init(iconType: 1, leftDay: 20, description: "가나다"))
}

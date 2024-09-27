//
//  WeeklyStudyContentCell.swift
//  BBIP
//
//  Created by 이건우 on 9/28/24.
//

import SwiftUI

struct WeeklyStudyContentCell: View {
    private let weekVal: Int
    private let content: String
    
    init(weekVal: Int, content: String) {
        self.weekVal = weekVal
        self.content = content
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.mainWhite)
                .frame(height: 70)
            
            HStack(spacing: 16) {
                Circle()
                    .foregroundStyle(.gray3)
                    .frame(width: 36)
                    .overlay() {
                        Text(weekVal.description)
                            .font(.bbip(.body1_sb16))
                            .foregroundStyle(.gray8)
                    }
                    .padding(.leading, 18)
                
                VStack(spacing: 5) {
                    Text(content)
                        .font(.bbip(.body1_sb16))
                }
                
                Spacer()
            }
        }
        .bbipShadow1()
    }
}

#Preview {
    WeeklyStudyContentCell(weekVal: 8, content: "리스닝 리딩")
}

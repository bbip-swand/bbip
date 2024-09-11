//
//  NoticeBannerView.swift
//  BBIP
//
//  Created by 이건우 on 9/10/24.
//

import SwiftUI

struct NoticeBannerView: View {
    private let pendingNotice: String
    
    init(pendingNotice: String) {
        self.pendingNotice = pendingNotice
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text("공지")
                .foregroundStyle(.primary3)
                .font(.bbip(.body1_sb16))
                .padding(.trailing, 5)
                .padding(.vertical, 2)
                .overlay(
                    Circle()
                    .fill(.primary3)
                    .frame(width: 4, height: 4),
                    alignment: .topTrailing
                )
                .padding(.trailing, 19)
            
            Text(pendingNotice)
                .font(.bbip(.body2_m14))
                .foregroundStyle(.gray8)
                .frame(maxWidth: 284, maxHeight: 20, alignment: .leading)
            
            Spacer()
        }
        .padding(.leading, 11)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.gray2)
                .frame(height: 40)
        )
        .padding(.horizontal, 16)
    }
}

#Preview {
    NoticeBannerView(
        pendingNotice: "다음 주 스터디 하루 쉬어갑니다! 다들 확인해주세요오오"
    )
}

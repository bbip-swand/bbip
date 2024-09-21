//
//  HomeBulletnboardCell.swift
//  BBIP
//
//  Created by 이건우 on 9/10/24.
//

import SwiftUI

//enum BulletnboardCellType {
//    case card
//    case list
//}

struct HomeBulletnboardCell: View {
    private var vo: HomeBulletnboardPostVO
    
    init(vo: HomeBulletnboardPostVO) {
        self.vo = vo
    }
    
    var capsuleViewType: CapsuleViewType {
        vo.postType == .normal
        ? .normal
        : .highlight
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 171, height: 115)
                .foregroundStyle(.mainWhite)
            
            VStack(alignment: .leading, spacing: 0) {
                CapsuleView(title: vo.studyName, type: capsuleViewType)
                    .padding(.bottom, 12)
                
                Text(vo.postContent)
                    .frame(maxWidth: 137, maxHeight: 34)
                    .font(.bbip(.body2_m14))
                    .padding(.bottom, 7)
                
                Text(timeAgo(date: vo.createdAt))

                    .font(.bbip(.caption3_r12))
                    .foregroundStyle(.gray6)
                    .frame(maxWidth: 137, alignment: .trailing)
            }
        }
    }
}

#Preview {
    HomeBulletnboardCell(
        vo:.init(postType: .normal,
                 studyName: "포트폴리오 스터디",
                 postContent: "오늘 스터디는 강서구 카페베네에서 진행합니달라",
                 createdAt: Date())
    )

}

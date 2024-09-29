//
//  HomeBulletnboardCell.swift
//  BBIP
//
//  Created by 이건우 on 9/10/24.
//

import SwiftUI

enum BulletnboardCellType {
    case userHome
    case studyHome
}

struct BulletnboardCell: View {
    private var vo: PostVO
    private var type: BulletnboardCellType
    
    init(
        vo: PostVO,
        type: BulletnboardCellType
    ) {
        self.vo = vo
        self.type = type
    }
    
    var capsuleViewType: CapsuleViewType {
        switch (type, vo.postType) {
        case (_, .notice):
            return .highlight
        case (.userHome, .normal):
            return .normal
        case (.studyHome, .normal):
            return .fill
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 171, height: 115)
                .foregroundStyle(.mainWhite)
            
            VStack(alignment: .leading, spacing: 0) {
                if type == .userHome {
                    CapsuleView(title: vo.studyName, type: capsuleViewType)
                        .padding(.bottom, 12)
                } else {
                    CapsuleView(title: vo.postType == .notice ? "공지" : "\(vo.week)주차", type: capsuleViewType)
                        .padding(.bottom, 12)
                }
                
                Text(vo.title)
                    .frame(maxWidth: 137, maxHeight: 34, alignment: .leading)
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

struct HomeBulletnboardCellPlaceholder: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 171, height: 115)
                .foregroundStyle(.gray2)
            
            VStack(alignment: .leading, spacing: 0) {
                CapsuleView(title: "BBIP", type: .placeholder)
                    .padding(.bottom, 12)
                
                Text("등록된 글이 없어요")
                    .font(.bbip(.body1_sb16))
                    .foregroundStyle(.gray6)
            }
            .padding(.leading, 13)
            .padding(.top, 11)
        }
    }
}

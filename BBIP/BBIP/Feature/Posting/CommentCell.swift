//
//  CommentCell.swift
//  BBIP
//
//  Created by 이건우 on 10/1/24.
//

import SwiftUI

struct CommentCell: View {
    private let vo: CommentVO
    
    init(vo: CommentVO) {
        self.vo = vo
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            LoadableImageView(imageUrl: vo.profileImageUrl, size: 36)
                .padding(.vertical, 2)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(vo.writer)
                    .font(.bbip(.body2_b14))
                
                Text(vo.content)
                    .font(.bbip(.body2_m14))
            }
            .foregroundStyle(.gray8)
            
            Spacer()
            
            Text(vo.timeAgo)
                .font(.bbip(.caption3_r12))
                .foregroundStyle(.gray5)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 26)
        .overlay(alignment: .bottom) {
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray3)
        }
    }
}

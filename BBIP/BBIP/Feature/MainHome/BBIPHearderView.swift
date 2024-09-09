//
//  BBIPHearderView.swift
//  BBIP
//
//  Created by 조예린 on 8/29/24.
//

import Foundation
import SwiftUI

struct BBIPHearderView: View {
    @Binding var showDot: Bool
    var title: String
    let onNoticeTapped: () -> Void
    let onProfileTapped: () -> Void
    
    init(
        showDot: Binding<Bool>,
        title: String = "홈",
        onNoticeTapped: @escaping () -> Void,
        onProfileTapped: @escaping () -> Void
    ) {
        self._showDot = showDot
        self.title = title
        self.onNoticeTapped = onNoticeTapped
        self.onProfileTapped = onProfileTapped
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .font(.bbip(.title3_m20))
                .foregroundStyle(.mainBlack)
                .padding(.leading, 20)
            
            Spacer()
            
            HStack(spacing: 24) {
                Button {
                    withAnimation { onNoticeTapped() }
                } label: {
                    Image("notice_icon")
                        .overlay(
                            Group {
                                if showDot {
                                    Circle()
                                        .fill(.primary3)
                                        .frame(width: 3.5, height: 3.5)
                                        .offset(x: 2, y: -3)
                                }
                            },
                            alignment: .topTrailing
                        )
                }
                
                Button {
                    withAnimation { onProfileTapped() }
                } label: {
                    Image("profile_icon")
                        .padding(.trailing, 28)
                }
            }
        }
        .frame(height: 42)
        .background(.gray1)
    }
}


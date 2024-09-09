//
//  MainHomeHeader.swift
//  BBIP
//
//  Created by 조예린 on 8/29/24.
//

import Foundation
import SwiftUI


struct CustomHeaderView: View {
    var title: String = "홈"
    var showDot: Bool = false
    let onNoticeTapped: () -> Void
    let onProfileTapped: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .font(.bbip(.title3_m20))
                .foregroundStyle(.mainBlack)
                .padding(.leading, 20)
            
            Spacer()
            
            HStack(spacing: 24) {
                Button {
                    onNoticeTapped()
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
                    onProfileTapped()
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


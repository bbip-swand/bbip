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
    var studyName: String
    var tabState: MainHomeTab
    let onNoticeTapped: () -> Void
    let onProfileTapped: () -> Void
    
    init(
        studyName: String = "홈",
        showDot: Binding<Bool>,
        onNoticeTapped: @escaping () -> Void,
        onProfileTapped: @escaping () -> Void,
        tabState: MainHomeTab
    ) {
        self.studyName = studyName
        self._showDot = showDot
        self.onNoticeTapped = onNoticeTapped
        self.onProfileTapped = onProfileTapped
        self.tabState = tabState
    }
    
    var title: String {
        tabState == .userHome ? "홈" : studyName
    }
    
    var titleMaxWidth: CGFloat {
        UIScreen.main.bounds.width - 144
    }
    
    var tintColor: Color {
        tabState == .userHome ? .mainBlack : .mainWhite
    }
    
    var font: Font {
        tabState == .userHome ? .bbip(.title3_m20) : .bbip(.title4_sb24)
    }
    
    var backgroundColor: Color {
        tabState == .userHome ? .gray1 : .gray9
    }
    
    var body: some View {
        if tabState == .calendar {
            EmptyView()
        } else {
            HStack(spacing: 0) {
                Text(title)
                    .font(font)
                    .foregroundStyle(tintColor)
                    .frame(maxWidth: titleMaxWidth, alignment: .leading)
                    .padding(.leading, 20)
                
                Spacer()
                
                HStack(spacing: 24) {
                    Button {
                        withAnimation { onNoticeTapped() }
                    } label: {
                        Image("notice_icon")
                            .renderingMode(.template)
                            .foregroundStyle(tintColor)
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
                            .renderingMode(.template)
                            .foregroundStyle(tintColor)
                            .padding(.trailing, 28)
                    }
                }
            }
            .frame(height: 42)
            .background(backgroundColor)
        }
    }
}


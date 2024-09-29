import Foundation
import SwiftUI

struct BBIPHeaderView: View {
    @EnvironmentObject var appState: AppStateManager
    @Binding var showDot: Bool
    var studyName: String
    var tabState: MainHomeTab

    private var title: String {
        tabState == .userHome ? "홈" : studyName
    }

    private var titleMaxWidth: CGFloat {
        UIScreen.main.bounds.width - 144
    }

    private var tintColor: Color {
        tabState == .userHome ? .mainBlack : .mainWhite
    }

    private var font: Font {
        tabState == .userHome ? .bbip(.title3_m20) : .bbip(.title4_sb24)
    }

    private var backgroundColor: Color {
        tabState == .userHome ? .gray1 : .gray9
    }

    private var noticeButton: some View {
        Button {
            appState.push(.notice)
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
    }

    private var profileButton: some View {
        Button {
            appState.push(.mypage)
        } label: {
            Image("profile_icon")
                .renderingMode(.template)
                .foregroundStyle(tintColor)
                .padding(.trailing, 28)
        }
    }

    private var moreButton: some View {
        Button {
            appState.push(.studyDetail)
        } label: {
            Image("more")
                .renderingMode(.template)
                .foregroundStyle(tintColor)
                .padding(.trailing, 28)
        }
    }

    private var toolBar: some View {
        HStack(spacing: 24) {
            if tabState == .userHome {
                noticeButton
                profileButton
            } else {
                moreButton
            }
        }
    }

    var body: some View {
        if tabState != .calendar {
            HStack(spacing: 0) {
                Text(title)
                    .font(font)
                    .foregroundStyle(tintColor)
                    .frame(maxWidth: titleMaxWidth, alignment: .leading)
                    .padding(.leading, 20)

                Spacer()
                toolBar
            }
            .frame(height: 42)
            .background(backgroundColor)
        }
    }
}

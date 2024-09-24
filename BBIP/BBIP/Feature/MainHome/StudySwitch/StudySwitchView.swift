//
//  StudySwitchView.swift
//  BBIP
//
//  Created by 이건우 on 9/14/24.
//

import SwiftUI

struct StudySwitchView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appState: AppStateManager
    @Binding var selectedTab: MainHomeTab
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 8) {
                ForEach(0..<2, id: \.self) {_ in 
                    StudySwitchViewCell()
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                            selectedTab = .studyHome
                        }
                }
            }
            .padding(.top, 10)
            
            MainButton(text: "스터디 생성하기", font: .bbip(.button2_m16)) {
                presentationMode.wrappedValue.dismiss()
                appState.push(.startSIS)
            }
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.gray2)
    }
}

private struct StudySwitchViewCell: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.mainWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 94)
                .padding(.horizontal, 20)
        }
    }
}

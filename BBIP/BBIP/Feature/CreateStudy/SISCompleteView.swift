//
//  SISCompleteView.swift
//  BBIP
//
//  Created by 이건우 on 8/31/24.
//

import SwiftUI

struct SISCompleteView: View {
    @EnvironmentObject private var appState: AppStateManager
    @State private var showDismissButton: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                
                Button {
                    appState.popToRoot()
                } label: {
                    Image("xmark")
                }
                .opacity(showDismissButton ? 1 : 0)
                .padding(.trailing, 28)
            }
            .frame(height: 42)
            
            Group {
                Text("스터디 생성이 완료되었습니다")
                    .font(.bbip(.title4_sb24))
                    .foregroundStyle(.mainWhite)
                    .padding(.top, 73)
                    .padding(.bottom, 10)
                
                Text("아래 버튼을 눌러 팀원에게 참여 링크를 공유하세요")
                    .font(.bbip(.caption1_m16))
                    .foregroundStyle(.gray6)
                    .padding(.bottom, 69)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            
            BBIPLottieView(assetName: "BBIPLoading") // 임시
            
            MainButton(text: "공유하기") {
                // handle sharing (deepLink)
            }
            .padding(.bottom, 22)
            .padding(.top, 69)
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.gray9)
        .navigationBarBackButtonHidden()
        .onAppear {
            HapticManager.shared.boong()
            
            // 2초 후에 X버튼을 표시
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation { showDismissButton = true }
            }
        }
    }
}

#Preview {
    SISCompleteView()
}

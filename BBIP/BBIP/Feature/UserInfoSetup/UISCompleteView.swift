//
//  UISCompleteView.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import SwiftUI

struct UISCompleteView: View {
    @EnvironmentObject private var appState: AppStateManager
    private let userStateManager = UserStateManager()
    private let userName: String
    
    init(userName: String) {
        self.userName = userName
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            Spacer()
            
            Image("mockImg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 64)
            
            Text("회원가입 완료!")
                .font(.bbip(.body1_m16))
                .foregroundStyle(.gray6)
                .padding(.top, 47)
                .padding(.bottom, 14)
            
            Group {
                Text("\(userName)님,")
                    .padding(.bottom, 4)
                Text("환영합니다!")
                    .padding(.bottom, 20)
            }
            .font(.bbip(.title1_sb28))
            
            Spacer()
            
            MainButton(text: "시작하기") {
                userStateManager.checkIsNewUser { isNew in
                    appState.switchRoot(isNew ? .startGuide : .home)
                }
            }
            .padding(.bottom, 39)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            HapticManager.shared.boong()
        }
    }
}

#Preview {
    UISCompleteView(userName: "박김밥")
}

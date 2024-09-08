//
//  HeaderComponent.swift
//  BBIP
//
//  Created by 조예린 on 9/8/24.
//

import SwiftUI

struct ElseHeaderView: View {
    // 타이틀과 프로필 아이콘의 디폴트 값을 설정합니다.
    var title: String = "Page Title" // 디폴트 헤더 타이틀
    var headerIconName: String = "" // 디폴트 오른쪽 아이콘 이미지 이름
    
    
    var body: some View {
        HStack(spacing: 0) {
            // 백버튼
            Button(action: {
              
            }) {
                Image("backButton")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.gray9)
            }
            .padding(.leading, 16)
            .backButtonStyle(isReversal: false)
            
            Spacer()
            
            // 타이틀
            Text(title)
                .font(.bbip(.title3_m20))
                .foregroundStyle(.mainBlack)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
            
            // 프로필 아이콘
            Button(action: {
                
            }) {
                Image(headerIconName) // 프로필 아이콘 이미지
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 28)
            }
        }
        .frame(height: 44)
        .background(.gray1)
    }
}

#Preview {
    ElseHeaderView()
}

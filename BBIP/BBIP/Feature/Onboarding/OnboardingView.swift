//
//  OnboardingView.swift
//  BBIP
//
//  Created by 이건우 on 8/10/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var selection = 0
    private let imageName = ["a", "b", "c", "d"]
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                
                // 추후 이미지로 변경
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.gray3)
                    .padding(.horizontal, 58)
                    .padding(.top, 230)
                    .tag(0)
                
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.gray4)
                    .padding(.horizontal, 58)
                    .padding(.top, 230)
                    .tag(1)
                
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.gray5)
                    .padding(.horizontal, 58)
                    .padding(.top, 230)
                    .tag(2)
                
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.gray6)
                    .padding(.horizontal, 58)
                    .padding(.top, 230)
                    .tag(3)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack(spacing: 8) {
                ForEach(0..<imageName.count, id: \.self) { index in
                    Circle()
                        .fill(selection == index ? Color.gray7 : Color.gray3)
                        .frame(width: 8, height: 8)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 52)
            
            VStack(spacing: 5) {
                Text("한눈에 보이는 학습,")
                    .font(.bbip(family: .Regular, size: 28))
                Text("함께하는 도전")
                    .font(.bbip(.title1_sb28))
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 113)
            
            Rectangle()
                .frame(height: 160)
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.gray1, Color.clear]),
                        startPoint: UnitPoint(x: 0.5, y: 0.05),
                        endPoint: UnitPoint(x: 0.5, y: 0)
                    )
                )
                .frame(maxHeight: .infinity, alignment: .bottom)
                .edgesIgnoringSafeArea(.bottom)
            
            MainButton(text: "다음") {
                withAnimation {
                    if selection < imageName.count - 1 {
                        selection += 1
                    } else {
                        selection = 0
                        // go login
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 39)
        }
    }
}

#Preview {
    OnboardingView()
}

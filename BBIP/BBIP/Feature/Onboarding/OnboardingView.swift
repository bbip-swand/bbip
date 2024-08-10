//
//  OnboardingView.swift
//  BBIP
//
//  Created by 이건우 on 8/10/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var selection = 0
    private let onboardingData: [OnboardingData]
    
    init() {
        self.onboardingData = OnboardingView.generate()
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                
                // 추후 이미지로 변경
                ForEach(0..<onboardingData.count, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color.gray4)
                        .padding(.horizontal, 58)
                        .padding(.top, 230)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack(spacing: 8) {
                ForEach(0..<onboardingData.count, id: \.self) { index in
                    Circle()
                        .fill(selection == index ? Color.gray7 : Color.gray3)
                        .frame(width: 8, height: 8)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 52)
            
            VStack(spacing: 5) {
                Text(onboardingData[selection].firstTitle)
                    .font(.bbip(family: .Regular, size: 28))
                Text(onboardingData[selection].secondTitle)
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
                .ignoresSafeArea(edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
            
            MainButton(text: "다음") {
                withAnimation {
                    if selection < onboardingData.count - 1 {
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

private extension OnboardingView {
    struct OnboardingData: Hashable {
        let firstTitle: String
        let secondTitle: String
        let imageName: String
    }
    
    static func generate() -> [OnboardingData] {
        return [
            OnboardingData(firstTitle: "한눈에 보이는 학습", secondTitle: "함께하는 도전1", imageName: "a"),
            OnboardingData(firstTitle: "두눈에 보이는 학습", secondTitle: "함께하는 도전2", imageName: "b"),
            OnboardingData(firstTitle: "세눈에 보이는 학습", secondTitle: "함께하는 도전3", imageName: "c"),
            OnboardingData(firstTitle: "네눈에 보이는 학습", secondTitle: "함께하는 도전4", imageName: "d")
        ]
    }
}

#Preview {
    OnboardingView()
}

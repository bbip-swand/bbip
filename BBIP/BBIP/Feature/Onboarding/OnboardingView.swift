//
//  OnboardingView.swift
//  BBIP
//
//  Created by 이건우 on 8/10/24.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        ZStack {
            
            OnboardingContentView(
                onboardingViewModel: onboardingViewModel,
                selectedIndex: $selectedIndex
            )
            
            HStack(spacing: 8) {
                ForEach(0..<onboardingViewModel.onboardingContents.count, id: \.self) { index in
                    Circle()
                        .fill(selectedIndex == index ? Color.gray7 : Color.gray3)
                        .frame(width: 8, height: 8)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 52)
            
            VStack(spacing: 5) {
                Text(onboardingViewModel.onboardingContents[selectedIndex].firstTitle)
                    .font(.bbip(family: .Regular, size: 28))
                Text(onboardingViewModel.onboardingContents[selectedIndex].secondTitle)
                    .font(.bbip(.title1_sb28))
                    .monospacedDigit()
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
                    if selectedIndex < onboardingViewModel.onboardingContents.count - 1 {
                        selectedIndex += 1
                    } else {
                        selectedIndex = 0
                        // go login
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 39)
        }
    }
}

private struct OnboardingContentView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    @Binding var selectedIndex: Int
    
    fileprivate init(
        onboardingViewModel: OnboardingViewModel,
        selectedIndex: Binding<Int>
    ) {
        self.onboardingViewModel = onboardingViewModel
        self._selectedIndex = selectedIndex
    }
    
    fileprivate var body: some View {
        TabView(selection: $selectedIndex) {
            // 추후 이미지로 변경
            ForEach(Array(onboardingViewModel.onboardingContents.enumerated()), id: \.element) { index, content in
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color.gray4)
                    .padding(.horizontal, 58)
                    .padding(.top, 230)
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

#Preview {
    OnboardingView()
}

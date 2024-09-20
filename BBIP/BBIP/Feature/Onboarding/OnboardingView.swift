//
//  OnboardingView.swift
//  BBIP
//
//  Created by 이건우 on 8/10/24.
//

import SwiftUI
import SwiftUIIntrospect

struct OnboardingView: View {
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex) {
                OnboardingContentView(onboardingViewModel: onboardingViewModel)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .introspect(.tabView(style: .page), on: .iOS(.v17, .v18)) { tabView in
                tabView.isScrollEnabled = false
            }
            
            TabViewPageIndicator(
                contentCount: onboardingViewModel.onboardingContents.count,
                selectedIndex: $selectedIndex
            )
            
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
                        onboardingViewModel.showLoginView = true
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 39)
        }
        .background(Color.gray1)
        .navigationDestination(isPresented: $onboardingViewModel.showLoginView) {
            LoginView()
        }
    }
}

private struct OnboardingContentView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    
    fileprivate init(onboardingViewModel: OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
    }
    
    fileprivate var body: some View {
        // 추후 이미지로 변경
        ForEach(Array(onboardingViewModel.onboardingContents.enumerated()), id: \.element) { index, content in
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color.gray4)
                .padding(.horizontal, 58)
                .padding(.top, 230)
                .tag(index)
        }
    }
}

private struct TabViewPageIndicator: View {
    @State private var contentCount: Int
    @Binding var selectedIndex: Int
    
    fileprivate init(
        contentCount: Int,
        selectedIndex: Binding<Int>
    ) {
        self.contentCount = contentCount
        self._selectedIndex = selectedIndex
    }
    
    fileprivate var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<contentCount, id: \.self) { index in
                Circle()
                    .fill(selectedIndex == index ? Color.gray8 : Color.gray3)
                    .frame(width: 8, height: 8)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 52)
    }
}

#Preview {
    OnboardingView()
}

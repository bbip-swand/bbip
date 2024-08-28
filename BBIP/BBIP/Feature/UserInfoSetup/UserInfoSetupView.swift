//
//  UserInfoSetupView.swift
//  BBIP
//
//  Created by 이건우 on 8/14/24.
//

import SwiftUI

struct UserInfoSetupView: View {
    @StateObject private var userInfoSetupViewModel = UserInfoSetupViewModel()
    @State private var selectedIndex: Int = 0
    
    private func buttonText() -> String {
        guard selectedIndex == 1 else { return "다음" }
        guard !userInfoSetupViewModel.selectedInterestIndex.isEmpty else { return "다음" }
        return "\(userInfoSetupViewModel.selectedInterestIndex.count)개 선택"
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex) {
                UISActiveAreaView(viewModel: userInfoSetupViewModel)
                    .tag(0)
                
                UISInterestView(viewModel: userInfoSetupViewModel)
                    .tag(1)
                
                UISProfileView(viewModel: userInfoSetupViewModel)
                    .tag(2)
                
                UISBirthView(viewModel: userInfoSetupViewModel)
                    .tag(3)
                
                Text("fifth")
                    .tag(4)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            VStack(spacing: 0) {
                TabViewProgressBar(value: bindingCalculateProgress(currentValue: $selectedIndex, totalCount: userInfoSetupViewModel.contentData.count))
                    .padding(.top, 20)
                    .background(Color.gray1)
                
                UISHeaderView(
                    title: userInfoSetupViewModel.contentData[selectedIndex].title,
                    subTitle: userInfoSetupViewModel.contentData[selectedIndex].subTitle ?? ""
                )
                .padding(.top, 48)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)

                Spacer()
                   
                MainButton(
                    text: buttonText(),
                    enable: userInfoSetupViewModel.canGoNext[selectedIndex]
                ) {
                    withAnimation {
                        if selectedIndex < userInfoSetupViewModel.contentData.count - 1 {
                            selectedIndex += 1
                            print(selectedIndex)
                        } else {
                            // 회원가입 프로세스
                        }
                    }
                }
                .padding(.bottom, 22)
            }
        }
        .background(Color.gray1)
        .ignoresSafeArea(.keyboard)
        .handlingBackButtonStyle(currentIndex: $selectedIndex)
        .skipButton(selectedIndex: $selectedIndex, viewModel: userInfoSetupViewModel)
    }
}

private func bindingCalculateProgress(currentValue: Binding<Int>, totalCount: Int) -> Binding<Double> {
    return Binding<Double>(
        get: {
            guard currentValue.wrappedValue > 0 else { return 0.2 }
            return Double(currentValue.wrappedValue + 1) / Double(totalCount)
        },
        set: { _ in }
    )
}

private struct TabViewProgressBar: View {
    @Binding var value: Double
    
    fileprivate init(value: Binding<Double>) {
        self._value = value
    }
    
    fileprivate var body: some View {
        ProgressView(value: value)
            .progressViewStyle(LinearProgressViewStyle())
            .tint(.primary3)
            .animation(.easeInOut(duration: 0.1), value: value)
    }
}

fileprivate extension View {
    /// 관심사 선택시에만 보여지는 건너뛰기 버튼
    func skipButton(
        selectedIndex: Binding<Int>,
        viewModel: UserInfoSetupViewModel
    ) -> some View {
        self.toolbar {
            if selectedIndex.wrappedValue == 1 {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation { selectedIndex.wrappedValue += 1 }
                        viewModel.selectedInterestIndex.removeAll()
                    } label: {
                        Text("건너뛰기")
                            .font(.bbip(.caption1_m16))
                            .frame(height: 24)
                            .foregroundStyle(.gray5)
                    }
                }
            }
        }
    }
}

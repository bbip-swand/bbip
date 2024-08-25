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
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex) {
                UISProfileView()
                    .tag(0)
                
                UISBirthView()
                    .tag(1)
                
                Text("thrid")
                    .tag(2)
                
                Text("fourth")
                    .tag(3)
                
                Text("fifth")
                    .tag(4)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            VStack {
                TabViewProgressBar(value: bindingCalculateProgress(currentValue: $selectedIndex, totalCount: userInfoSetupViewModel.contentData.count))
                    .padding(.top, 20)
                    .background(Color.mainWhite)

                Spacer()
                   
                MainButton(text: "다음") {
                    withAnimation {
                        if selectedIndex < userInfoSetupViewModel.contentData.count - 1 {
                            selectedIndex += 1
                        } else {
                            selectedIndex = 0
                        }
                    }
                }
                .padding(.bottom, 22)
            }
        }
        .background(Color.gray1)
        .backButtonStyle()
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



#Preview {
    UserInfoSetupView()
}




//
//  StudyInfoSetupView.swift
//  BBIP
//
//  Created by 이건우 on 8/29/24.
//

import SwiftUI
import SwiftUIIntrospect

struct StudyInfoSetupView: View {
    @StateObject private var createStudyViewModel = CreateStudyViewModel()
    @State private var selectedIndex: Int = .zero
    
    init() {
        setNavigationBarAppearance(forDarkView: true)
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex) {
                SISCategoryView(viewModel: createStudyViewModel)
                    .tag(0)
                
                Text("second")
                    .tag(1)
                
                Text("third")
                    .tag(2)
                
                Text("fourth")
                    .tag(3)
                
                Text("fifth")
                    .tag(4)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .introspect(.tabView(style: .page), on: .iOS(.v17)) {
                $0.isScrollEnabled = false
            }
            
            VStack(spacing: 0) {
                TabViewProgressBar(value: .calculateProgress(currentValue: $selectedIndex, totalCount: createStudyViewModel.contentData.count))
                    .background(.gray7)
                    .padding(.top, 20)
                    .background(Color.gray9)
                
                TabViewHeaderView(
                    title: createStudyViewModel.contentData[selectedIndex].title,
                    subTitle: createStudyViewModel.contentData[selectedIndex].subTitle,
                    reversal: true
                )
                .padding(.top, 48)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)

                Spacer()
                   
                MainButton(
                    text: "다음",
                    enable: createStudyViewModel.canGoNext[selectedIndex],
                    disabledColor: .gray8
                ) {
                    withAnimation {
                        if selectedIndex < createStudyViewModel.contentData.count - 1 {
                            selectedIndex += 1
                            print(selectedIndex)
                        } else {
                            // 스터디 생성 프로세스
                        }
                    }
                }
                .padding(.bottom, 22)
            }
        }
        .navigationTitle("생성하기")
        .background(Color.gray9)
        .ignoresSafeArea(.keyboard)
        .handlingBackButtonStyle(currentIndex: $selectedIndex, isReversal: true)
        .skipButtonForSISDescriptionView(selectedIndex: $selectedIndex, viewModel: createStudyViewModel)
    }
}

fileprivate extension View {
    /// 스터디 한 줄 소개 작성 뷰에서만 보여지는 건너뛰기 버튼
    func skipButtonForSISDescriptionView(
        selectedIndex: Binding<Int>,
        viewModel: CreateStudyViewModel
    ) -> some View {
        self.toolbar {
            if selectedIndex.wrappedValue == 3 {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation { selectedIndex.wrappedValue += 1 }
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

#Preview {
    StudyInfoSetupView()
}

import SwiftUI

struct BackButtonModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    private let isReversal: Bool
    private let isReversalText: String
    
    init(
        isReversal: Bool,
        isReversalText: String
    ) {
        self.isReversal = isReversal
        self.isReversalText = isReversalText
    }

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if isReversal {
                        // 백 버튼 (이미지) - isReversal가 true일 때
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image("backButton")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.mainBlack)
                        }
                    } else if !isReversal && !isReversalText.isEmpty {
                        // 백 버튼 (텍스트) - isReversal가 false이고 isReversalText가 비어있지 않을 때
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text(isReversalText)
                                .foregroundStyle(.gray5)
                                .font(.bbip(.button2_m16))
                        }
                    }
                }
            }
    }
}

extension View {
    func backButtonStyle(isReversal: Bool = false, isReversalText: String = "") -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .modifier(BackButtonModifier(isReversal: isReversal, isReversalText: isReversalText))
    }
}

struct BackButtonHandlingModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    @Binding var currentIndex: Int
    private let isReversal: Bool
    private let isReversalText: String

    init(
        currentIndex: Binding<Int>,
        isReversal: Bool,
        isReversalText: String
    ) {
        self._currentIndex = currentIndex
        self.isReversal = isReversal
        self.isReversalText = isReversalText
    }
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if isReversal {
                        // 백 버튼 (이미지) - isReversal가 true일 때
                        Button {
                            if currentIndex > 0 {
                                withAnimation { currentIndex -= 1 }
                            } else {
                                presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            Image("backButton")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.mainWhite)
                        }
                    } else if !isReversal && !isReversalText.isEmpty {
                        // 백 버튼 (텍스트) - isReversal가 false이고 isReversalText가 비어있지 않을 때
                        Button {
                            if currentIndex > 0 {
                                withAnimation { currentIndex -= 1 }
                            } else {
                                presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            Text(isReversalText)
                                .foregroundStyle(.gray5)
                                .font(.bbip(.button2_m16))
                        }
                    }
                }
            }
    }
}

/// TabView에서 selectedIndex값을 handling할 수 있는 backButton
extension View {
    func handlingBackButtonStyle(
        currentIndex: Binding<Int>,
        isReversal: Bool = false,
        isReversalText: String = ""
    ) -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .modifier(BackButtonHandlingModifier(currentIndex: currentIndex, isReversal: isReversal, isReversalText: isReversalText))
    }
}


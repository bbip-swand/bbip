//
//  MainButton.swift
//  BBIP
//
//  Created by 이건우 on 8/10/24.
//

import SwiftUI

struct MainButton: View {
    typealias Action = () -> Void
    
    private var text: String
    private var enable: Bool
    private var action: Action
    private var disabledColor: Color // 추가된 부분
    
    init(
        text: String,
        enable: Bool = true,
        disabledColor: Color = .gray3, // 기본값 설정
        action: @escaping Action
    ) {
        self.text = text
        self.enable = enable
        self.disabledColor = disabledColor // 초기화
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.bbip(.button1_m20))
                .foregroundColor(enable ? .mainWhite : .gray5)
                .frame(width: UIScreen.main.bounds.width - 40, height: 56)
                .background(RoundedRectangle(cornerRadius: 12).fill(enable ? Color.primary3 : disabledColor))
        }
        .disabled(!enable)
    }
}

#Preview {
    VStack(spacing: 30) {
        MainButton(text: "활성화 버튼") {}
        MainButton(text: "비활성화 버튼", enable: false) {}
    }
    .padding(.horizontal)
}

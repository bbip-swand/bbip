//
//  UISInterestView.swift
//  BBIP
//
//  Created by 이건우 on 8/27/24.
//

import SwiftUI

struct UISInterestView: View {
    @ObservedObject var viewModel: UserInfoSetupViewModel
    
    var body: some View {
        GridButtonView(
            type: .interest,
            selectedIndex: $viewModel.selectedInterestIndex,
            maximumCount: 3 // 회원가입 시 관심사는 3개까지 중복 선택 가능
        )
        .onChange(of: viewModel.selectedInterestIndex) { _, newValue in
            viewModel.canGoNext[1] = !newValue.isEmpty
        }
        .padding(.top, 186)
        .padding(.horizontal, 20)
    }
}

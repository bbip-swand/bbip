//
//  UISJobView.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import SwiftUI

struct UISJobView: View {
    @ObservedObject var viewModel: UserInfoSetupViewModel
    
    var body: some View {
        GridButtonView(
            type: .job,
            selectedIndex: $viewModel.selectedJobIndex
        )
        .onChange(of: viewModel.selectedJobIndex) { _, newValue in
            viewModel.canGoNext[4] = !newValue.isEmpty
        }
        .padding(.top, 203)
        .padding(.horizontal, 20)
    }
}

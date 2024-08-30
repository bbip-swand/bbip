//
//  SISCategoryView.swift
//  BBIP
//
//  Created by 이건우 on 8/31/24.
//

import SwiftUI

struct SISCategoryView: View {
    @ObservedObject var viewModel: CreateStudyViewModel
    
    var body: some View {
        GridButtonView(
            type: .interest,
            selectedIndex: $viewModel.selectedCategoryIndex,
            isDarkMode: true
        )
        .onChange(of: viewModel.selectedCategoryIndex) { _, newValue in
            viewModel.canGoNext[0] = !newValue.isEmpty
        }
        .padding(.top, 186)
        .padding(.horizontal, 20)
    }
}

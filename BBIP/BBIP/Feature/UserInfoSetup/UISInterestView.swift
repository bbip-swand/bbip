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
            selectedIndex: $viewModel.selectedInterestIndex
        )
        .padding(.top, 186)
        .padding(.horizontal, 20)
    }
}

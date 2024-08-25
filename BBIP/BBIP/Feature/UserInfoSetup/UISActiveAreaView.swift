//
//  UISActiveAreaView.swift
//  BBIP
//
//  Created by 이건우 on 8/25/24.
//

import SwiftUI

struct UISActiveAreaView: View {
    @ObservedObject var viewModel: UserInfoSetupViewModel
    
    var body: some View {
        VStack(spacing: 0) {
        }
    }
}

#Preview {
    UISActiveAreaView(viewModel: UserInfoSetupViewModel())
}

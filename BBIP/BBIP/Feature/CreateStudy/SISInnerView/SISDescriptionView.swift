//
//  SISDescriptionView.swift
//  BBIP
//
//  Created by 이건우 on 8/31/24.
//

import SwiftUI

struct SISDescriptionView: View {
    @ObservedObject var viewModel: CreateStudyViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            CustomTextEditor(
                text: $viewModel.studyDescription,
                height: 150
            )
                .padding(.top, 192)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .keyboardHideable()
    }
}

//
//  StartCreateStudyView.swift
//  BBIP
//
//  Created by 이건우 on 8/29/24.
//

import SwiftUI

struct StartCreateStudyView: View {
    @State private var showStudyInfoSetupView: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Text("Content...")
                .font(.bbip(.title4_sb24))
                .foregroundStyle(.mainWhite)
            
            Spacer()
            
            MainButton(text: "시작하기") {
                showStudyInfoSetupView = true
            }
            .padding(.bottom, 22)
        }
        .frame(maxWidth: .infinity)
        .backButtonStyle(isReversal: true)
        .background(.gray9)
        .navigationDestination(isPresented: $showStudyInfoSetupView) {
            StudyInfoSetupView()
        }
    }
}

#Preview {
    StartCreateStudyView()
}

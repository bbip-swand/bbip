//
//  CheckStudyLocationView.swift
//  BBIP
//
//  Created by 이건우 on 10/1/24.
//

import SwiftUI

struct CheckStudyLocationView: View {
    @EnvironmentObject private var appState: AppStateManager
    private let location: String?
    
    init(location: String?) {
        self.location = location
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 18)
            Image("location_background")
            
            Text("이번 주차 장소는")
                .font(.bbip(.title4_sb24))
                .foregroundStyle(.mainWhite)
                .padding(.top, 50)
                .padding(.bottom, 16)
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 70)
                    .foregroundStyle(.gray8)
                    .padding(.horizontal, 20)
                
                Text(location ?? "미정")
                    .font(.bbip(.title1_sb28))
                    .foregroundStyle(location == nil ? .gray6 : .mainWhite)
            }
            
            Spacer()
            
            MainButton(text: "돌아가기") {
                appState.popToRoot()
            }
            .padding(.bottom, 22)
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.gray9)
        .backButtonStyle(isReversal: true)
    }
}

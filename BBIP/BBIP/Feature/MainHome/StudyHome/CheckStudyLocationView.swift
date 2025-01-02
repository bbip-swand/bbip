//
//  CheckStudyLocationView.swift
//  BBIP
//
//  Created by 이건우 on 10/1/24.
//

import SwiftUI

struct CheckStudyLocationView: View {
    @EnvironmentObject private var appState: AppStateManager
    @Environment(\.presentationMode) var presentationMode
    private let location: String?
    private let isManager: Bool
    
    init(
        location: String?,
        isManager: Bool
    ) {
        self.location = location
        self.isManager = isManager
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 60)
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
                if isManager {
                    appState.popToRoot()
                } else {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding(.bottom, 22)
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.gray9)
        .toolbar(.hidden)
    }
}

//
//  StudySwitchView.swift
//  BBIP
//
//  Created by 이건우 on 9/14/24.
//

import SwiftUI

struct StudySwitchView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var showCreateStudyView: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 8) {
                ForEach(0..<2, id: \.self) {_ in 
                    StudySwitchViewCell()
                }
            }
            .padding(.vertical, 12)
            
            HStack(spacing: 16) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                    showCreateStudyView = true
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.mainWhite)
                        .frame(height: 56)
                        .overlay {
                            Text("생성하기")
                                .font(.bbip(.button1_m20))
                                .foregroundStyle(.primary3)
                        }
                }
                
                Button {
                    // create
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.primary3)
                        .frame(height: 56)
                        .overlay {
                            Text("참여하기")
                                .font(.bbip(.button1_m20))
                                .foregroundStyle(.mainWhite)
                        }
                }
            }
            .padding(.horizontal, 16)
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.gray2)
    }
}

private struct StudySwitchViewCell: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.mainWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 94)
                .padding(.horizontal, 16)
        }
    }
}

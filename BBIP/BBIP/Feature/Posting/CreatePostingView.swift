//
//  CreatePostingView.swift
//  BBIP
//
//  Created by 이건우 on 11/20/24.
//

import SwiftUI

struct CreatePostingView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            selectWeekButton
                .padding(.bottom, 22)
            
            titleTextField
                .padding(.bottom, 8)
            
            postContentTextField
        }
        .padding(.horizontal, 16)
        .containerRelativeFrame(.vertical)
        .background(.gray1)
        .navigationTitle("글 작성")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            setNavigationBarAppearance(backgroundColor: .gray1)
        }
    }
}

extension CreatePostingView {
    var selectWeekButton: some View {
        Button {
            //
        } label: {
            HStack(spacing: 20) {
                Text("주차 선택")
                    .font(.bbip(.body2_m14))
                Image(systemName: "chevron.up")
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 14)
            .foregroundStyle(.gray5)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.mainWhite)
                    .bbipShadow1()
            )
        }
    }
    
    var titleTextField: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.mainWhite)
                .bbipShadow1()
                .frame(height: 41)
                .frame(maxWidth: .infinity)
            
            TextField(
                "",
                text: .constant(""),
                prompt: Text("제목 입력(20자 이내)").foregroundColor(.gray5)
            )
            .padding(.horizontal, 14)
            .font(.bbip(.body2_m14))
            .foregroundColor(.mainBlack)
        }
    }
    
    var postContentTextField: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.mainWhite)
                .bbipShadow1()
                .frame(height: 250)
                .frame(maxWidth: .infinity)
            
            TextField(
                "",
                text: .constant(""),
                prompt: Text("본문(300자 이내)").foregroundColor(.gray5)
            )
            .padding(.vertical, 12)
            .padding(.horizontal, 14)
            .font(.bbip(.body2_m14))
            .foregroundColor(.mainBlack)
        }
    }
}

#Preview {
    CreatePostingView()
}

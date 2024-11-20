//
//  PostingListView.swift
//  BBIP
//
//  Created by 이건우 on 11/20/24.
//

import SwiftUI

struct PostingListView: View {
    private let postData: [PostVO]
    
    init(postData: [PostVO]) {
        self.postData = postData
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if postData.isEmpty {
                EmptyPlaceholderView(message: "아직 작성한 글이 없어요")
            } else {
                ScrollView {
                    VStack(spacing: 25) {
                        ForEach(0..<postData.count, id: \.self) { index in
                            PostInfoCardView(vo: postData[index])
                        }
                    }
                    .padding(.vertical, 25)
                    Spacer()
                }
                .bbipShadow1()
            }
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.gray1)
        .navigationTitle("게시판")
        .navigationBarTitleDisplayMode(.inline)
        .backButtonStyle()
        .onAppear {
            setNavigationBarAppearance(backgroundColor: .gray1)
        }
    }
}

#Preview {
    PostingListView(postData: [])
}

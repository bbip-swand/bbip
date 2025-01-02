//
//  PostingListView.swift
//  BBIP
//
//  Created by 이건우 on 11/20/24.
//

import SwiftUI

struct PostingListView: View {
    @State private var showCreatePostingView: Bool = false
    
    private let studyId: String
    private let postData: [PostVO]
    private let weeklyStudyContent: [String]
    
    init(
        studyId: String,
        postData: [PostVO],
        weeklyStudyContent: [String]
    ) {
        self.studyId = studyId
        self.postData = postData
        self.weeklyStudyContent = weeklyStudyContent
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if postData.isEmpty {
                EmptyPlaceholderView(message: "아직 작성한 글이 없어요")
            } else {
                ScrollView {
                    VStack(spacing: 10) {
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showCreatePostingView = true
                } label: {
                    Image("write_posting")
                        .padding(.trailing, 8)
                }
            }
        }
        .navigationDestination(isPresented: $showCreatePostingView) {
            CreatePostingView(studyId: studyId, weeklyContent: weeklyStudyContent)
        }
        .onAppear {
            setNavigationBarAppearance(backgroundColor: .gray1)
        }
    }
}

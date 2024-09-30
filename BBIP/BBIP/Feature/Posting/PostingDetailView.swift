//
//  PostingDetailView.swift
//  BBIP
//
//  Created by 이건우 on 9/30/24.
//

import SwiftUI

struct PostingDetailView: View {
    @ObservedObject var viewModel: PostingDetailViewModel = DIContainer.shared.makePostingDetailViewModel()
    private let postId: String
    
    init(postId: String) {
        self.postId = postId
    }
    
    var body: some View {
         Text(postId)
            .onAppear {
                viewModel.getPostDetail(postingId: postId)
            }
    }
}

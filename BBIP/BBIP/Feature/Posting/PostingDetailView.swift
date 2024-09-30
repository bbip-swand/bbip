//
//  PostingDetailView.swift
//  BBIP
//
//  Created by 이건우 on 9/30/24.
//

import SwiftUI

struct PostingDetailView: View {
    private let postId: String
    
    init(postId: String) {
        self.postId = postId
    }
    
    var body: some View {
         Text(postId)
    }
}

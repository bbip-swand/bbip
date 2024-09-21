//
//  PostVO.swift
//  BBIP
//
//  Created by 이건우 on 9/21/24.
//

import Foundation

enum PostType {
    case notice // 공지 글
    case normal // 일반 글
}

/// UserHome 화면에서 보이는 게시판
typealias CurrentWeekPostVO = [PostVO]

struct PostVO {
    let postId: String
    let createdAt: Date
    let studyName: String
    let title: String
    let content: String
    let postType: PostType
}

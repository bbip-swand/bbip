//
//  BulletnboardVO.swift
//  BBIP
//
//  Created by 이건우 on 9/10/24.
//

import Foundation

enum BulletnboardPostType {
    case notice // 공지 글
    case normal // 일반 글
}

struct HomeBulletnboardPostVO {
    let postType: BulletnboardPostType
    let studyName: String
    let postContent: String
    let createdAt: Date
}

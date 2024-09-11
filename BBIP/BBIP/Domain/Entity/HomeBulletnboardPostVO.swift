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

extension HomeBulletnboardPostVO {
    static func generateMock() -> [HomeBulletnboardPostVO] {
        return [
            HomeBulletnboardPostVO(postType: .notice, studyName: "포트폴리오 스터디", postContent: "오늘 스터디는 강서구 카페베네에서 진행합니다", createdAt: Date().addingTimeInterval(-10000)),
            HomeBulletnboardPostVO(postType: .normal, studyName: "JLPT N2 청해 스터디", postContent: "오늘 스터디는 강서구 카페베네에서 진행합니다", createdAt: Date().addingTimeInterval(-30000)),
            HomeBulletnboardPostVO(postType: .notice, studyName: "포트폴리오 스터디", postContent: "오늘 스터디는 강서구 카페베네에서 진행합니다", createdAt: Date().addingTimeInterval(-300000)),
            HomeBulletnboardPostVO(postType: .normal, studyName: "JLPT N2 청해 스터디", postContent: "오늘 스터디는 강서구 카페베네에서 진행합니다", createdAt: Date().addingTimeInterval(-4000000)),
            HomeBulletnboardPostVO(postType: .notice, studyName: "포트폴리오 스터디", postContent: "오늘 스터디는 강서구 카페베네에서 진행합니다", createdAt: Date().addingTimeInterval(-5000000))
        ]
    }
}


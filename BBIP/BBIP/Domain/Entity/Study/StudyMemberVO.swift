//
//  StudyMemberVO.swift
//  BBIP
//
//  Created by 이건우 on 9/29/24.
//

import Foundation

/// 스터디 참여 멤버 정보 DTO
struct StudyMemberVO {
    let memberName: String
    let isManager: Bool
    let memberImageURL: String?
    let interest: [StudyCategory]
}

extension StudyMemberVO {
    static func placeholderMock() -> StudyMemberVO {
        return .init(
            memberName: "mock",
            isManager: false,
            memberImageURL: nil,
            interest: [.certification]
        )
    }
}

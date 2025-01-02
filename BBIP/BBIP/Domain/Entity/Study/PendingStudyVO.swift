//
//  PendingStudyVO.swift
//  BBIP
//
//  Created by 이건우 on 11/19/24.
//

import Foundation

struct PendingStudyVO {
    let studyId: String
    let studyName: String
    let studyWeek: Int
    let studyTime: String
    let leftDays: Int
    let place: String
    let totalWeeks: Int
}

extension PendingStudyVO {
    static func mock() -> Self {
        return .init(
            studyId: "1",
            studyName: "placeholder",
            studyWeek: 2,
            studyTime: "12:00 ~ 13:00",
            leftDays: 1,
            place: "placeholder",
            totalWeeks: 5
        )
    }
}

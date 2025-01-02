//
//  AttendanceStatusVO.swift
//  BBIP
//
//  Created by 이건우 on 11/18/24.
//

struct AttendanceStatusVO {
    let studyName: String
    let studyId: String
    let session: Int
    var remainingTime: Int
    let code: Int
    let isManager: Bool
    let isAttended: Bool
}
